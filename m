Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443484A9898
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358495AbiBDLu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:50:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4671 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241452AbiBDLu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:50:57 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jqtz42Yn2z67VnM;
        Fri,  4 Feb 2022 19:46:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 12:50:55 +0100
Received: from [10.47.87.24] (10.47.87.24) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Feb
 2022 11:50:47 +0000
Content-Type: multipart/mixed;
        boundary="------------Om3S7qykNY4xaw3MSzqO7tsA"
Message-ID: <c3cb7228-254e-9584-182b-007ac5e6fe0a@huawei.com>
Date:   Fri, 4 Feb 2022 11:50:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 00/16] scsi: libsas and users: Factor out LLDD TMF code
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1893d9ef-042b-af3b-74ea-dd4d0210c493@opensource.wdc.com>
 <14df160f-c0f2-cc9f-56d4-8eda67969e0b@huawei.com>
 <a8fae323-1877-058a-b03e-d175a725213f@opensource.wdc.com>
 <a2de1656-b1ec-2fb7-caab-657e27dacb48@huawei.com>
 <49da4d80-5cc3-35c3-ccaa-6def8165eb65@huawei.com>
 <59a198a8-1d87-bc09-d2d8-2d495ed74c16@opensource.wdc.com>
 <098f988e-1f12-c412-3111-60393dfe0f0b@huawei.com>
 <f3362c6f-b4b6-2914-0652-d786e19b6b03@opensource.wdc.com>
 <62e56609-7026-93a1-a446-a6fd68328653@opensource.wdc.com>
 <e8af9d55-bf36-faa0-defb-3a9a4931826e@huawei.com>
 <2bd15f44-0b56-b6e0-8ef8-c33ba9ee7caa@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <2bd15f44-0b56-b6e0-8ef8-c33ba9ee7caa@opensource.wdc.com>
X-Originating-IP: [10.47.87.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------Om3S7qykNY4xaw3MSzqO7tsA
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 04/02/2022 11:27, Damien Le Moal wrote:
>> As I mentioned, having this fail is a red flag. If I was pushed to guess
>> what has happened, I'd say the FW is faulting due to some erroneous
>> driver behaviour.
> I am still thinking that there is something wrong with the handling of
> NCQ NON DATA command. There are several places where the code determines
> non-data vs pio vs dma vs fpdma (ncq), and NCQ NON DATA always falls in
> the fpdma bucket, which is wrong.
> 

Ok, I will have a look at this. We made some libsas changes related to 
this not so long ago to "fix" something, see:

53de092f47f ("scsi: libsas: Set data_dir as DMA_NONE if libata marks qc 
as NODATA")

176ddd89171d ("scsi: libsas: Reset num_scatter if libata marks qc as 
NODATA")

>>> This is the submission path, not completion. The code is:
>>>
>>> (gdb) list *(pm8001_queue_command+0x842)
>>> 0x3d42 is in pm8001_queue_command (drivers/scsi/pm8001/pm8001_sas.c:491).
>>> 486				atomic_dec(&pm8001_dev->running_req);
>>> 487				goto err_out_tag;
>>> 488			}
>>> 489			/* TODO: select normal or high priority */
>>> 490			spin_lock(&t->task_state_lock);
>>> 491			t->task_state_flags |= SAS_TASK_AT_INITIATOR;
>>> 492			spin_unlock(&t->task_state_lock);
>>> 493		} while (0);
>>> 494		rc = 0;
>>> 495		goto out_done;
>>>
>>> So the task is already completed when the submission path tries to set
>>> the state flag ? Debugging...
>> Yeah, that's how it looks.
>>
>> I already mentioned this problem here:
>>
>> https://lore.kernel.org/linux-scsi/0cc0c435-b4f2-9c76-258d-865ba50a29dd@huawei.com/
>>
>> Maybe we should just fix it now to rule it out of possibly causing other
>> issues... I was reluctant to fix it as many places seems to need to be
>> touched. Let me check it.
> Here is my current fix:
> 
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c
> b/drivers/scsi/pm8001/pm8001_sas.c
> index 1b95c73d12d1..16c101577dd3 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -453,13 +453,18 @@ int pm8001_queue_command(struct sas_task *task,
> gfp_t gfp_flags)
>                  ccb->ccb_tag = tag;
>                  ccb->task = t;
>                  ccb->device = pm8001_dev;
> +
> +               /* TODO: select normal or high priority */
> +               atomic_inc(&pm8001_dev->running_req);
> +               spin_lock(&t->task_state_lock);
> +               t->task_state_flags |= SAS_TASK_AT_INITIATOR;
> +               spin_unlock(&t->task_state_lock);
> +
>                  switch (task_proto) {
>                  case SAS_PROTOCOL_SMP:
> -                       atomic_inc(&pm8001_dev->running_req);
>                          rc = pm8001_task_prep_smp(pm8001_ha, ccb);
>                          break;
>                  case SAS_PROTOCOL_SSP:
> -                       atomic_inc(&pm8001_dev->running_req);
>                          if (is_tmf)
>                                  rc = pm8001_task_prep_ssp_tm(pm8001_ha,
>                                          ccb, tmf);
> @@ -468,7 +473,6 @@ int pm8001_queue_command(struct sas_task *task,
> gfp_t gfp_flags)
>                          break;
>                  case SAS_PROTOCOL_SATA:
>                  case SAS_PROTOCOL_STP:
> -                       atomic_inc(&pm8001_dev->running_req);
>                          rc = pm8001_task_prep_ata(pm8001_ha, ccb);
>                          break;
>                  default:
> @@ -480,13 +484,12 @@ int pm8001_queue_command(struct sas_task *task,
> gfp_t gfp_flags)
> 
>                  if (rc) {
>                          pm8001_dbg(pm8001_ha, IO, "rc is %x\n", rc);
> +                       spin_lock(&t->task_state_lock);
> +                       t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
> +                       spin_unlock(&t->task_state_lock);
>                          atomic_dec(&pm8001_dev->running_req);
>                          goto err_out_tag;
>                  }
> -               /* TODO: select normal or high priority */
> -               spin_lock(&t->task_state_lock);
> -               t->task_state_flags |= SAS_TASK_AT_INITIATOR;
> -               spin_unlock(&t->task_state_lock);
>          } while (0);
>          rc = 0;
>          goto out_done;
> 
> With this, No KASAN complaint. I will send a proper patch ASAP.

I had just prepared a patch, but different, attached.

> 
> Of note is that I cannot see what the flag SAS_TASK_AT_INITIATOR is for.
> It is set and unset only, never tested anywhere in libsas nor pm8001
> driver. This flag seems totally useless to me, unless this is something
> that the HW can see ?

Right, it is only checked by isci AFAIC. And it is not something which 
HW can see.

Since libsas does not check it the semantics are ill-defined. However I 
think that it's worth setting it completeness; I thought it was better 
setting it just before the command is delivered to HW, but the 
implementation touches more SW. Simpler approach may be better since it 
aligns with how this flag may be cleared in pm8001_chip_sata_req() under 
asusmption it is already set.

Thanks,
John
--------------Om3S7qykNY4xaw3MSzqO7tsA
Content-Type: text/plain; charset="UTF-8";
	name="0001-scsi-pm8001-Set-SAS_TASK_AT_INITIATOR-before-deliver.patch"
Content-Disposition: attachment;
	filename*0="0001-scsi-pm8001-Set-SAS_TASK_AT_INITIATOR-before-deliver.pa";
	filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxYWVhNWQ0MDZkZTg4MDZkZTIyN2Y3OWMyNzI4ODk5OTU5MTUzNDAwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5j
b20+CkRhdGU6IEZyaSwgNCBGZWIgMjAyMiAxMToxMjoxMiArMDAwMApTdWJqZWN0OiBbUEFU
Q0hdIHNjc2k6IHBtODAwMTogU2V0IFNBU19UQVNLX0FUX0lOSVRJQVRPUiBiZWZvcmUgZGVs
aXZlcmluZwogdGFzawoKQm90aCBEYW1pZW4gYW5kIEkgaGF2ZSBzZWVuIGEgS0FTQU4gdXNl
LWFmdGVyLWZyZWUgd2FybiBmb3IgYWNjZXNzaW5nIGEKc2FzX3Rhc2sgYWZ0ZXIgZGVsaXZl
cmluZyB0aGUgYXNzb2NpYXRlZCBjb21tYW5kIHRvIEhXLgoKVGhlIGlzc3VlIGlzIHRoYXQg
b25jZSB0aGUgY29tbWFuZCBpcyBkZWxpdmVyZWQgaXQgaXMgY29tcGxldGVkIChhbmQgZnJl
ZWQpCmFzeW5jLCBhbmQsIGFzIHN1Y2gsIGl0IGlzIG5vdCBzYWZlIHRvIHRvdWNoIHRoZSBz
YXNfdGFzayBhZ2FpbiBpbiB0aGUKZGVsaXZlcnkgcGF0aC4KCkhvd2V2ZXIgdGhlIHNhc190
YXNrIGlzIHRvdWNoZWQgYWdhaW4gaW4gc2V0dGluZyB0aGUgdGFzayBzdGF0ZQpTQVNfVEFT
S19BVF9JTklUSUFUT1IgZmxhZy4gVGhlIHNlbWFudGljcyBmb3IgdGhhdCBmbGFnIGlzIG5v
dCBkZWZpbmVkLApzcGVjaWZpY2FsbHkgYmVjYXVzZSBpdCBpcyBub3QgY2hlY2tlZCBieSBs
aWJzYXMuIEluZGVlZCwgaXQgaXMgbm90IGV2ZW4KY2hlY2tlZCBieSB0aGlzIGRyaXZlci4g
Rm9yIHRoZSBzYWtlIG9mIGNvbXBsZXRlbmVzcywgc2V0IHRoYXQgZmxhZyBiZWZvcmUKZGVs
aXZlcmluZyB0aGUgY29tbWFuZCB0byB0aGUgSFcuCgpSZXBvcnRlZC1ieTogRGFtaWVuIExl
IE1vYWwgPGRhbWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMuY29tPgpTaWduZWQtb2ZmLWJ5
OiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+CgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zY3NpL3BtODAwMS9wbTgwMDFfaHdpLmMgYi9kcml2ZXJzL3Njc2kvcG04MDAxL3Bt
ODAwMV9od2kuYwppbmRleCBjODE0ZTUwNzE3MTIuLmM2ZjVhYTI3YmZiZiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9zY3NpL3BtODAwMS9wbTgwMDFfaHdpLmMKKysrIGIvZHJpdmVycy9zY3Np
L3BtODAwMS9wbTgwMDFfaHdpLmMKQEAgLTE3OTYsNiArMTc5Niw3IEBAIHN0YXRpYyB2b2lk
IHBtODAwMV9zZW5kX2Fib3J0X2FsbChzdHJ1Y3QgcG04MDAxX2hiYV9pbmZvICpwbTgwMDFf
aGEsCiAJdGFza19hYm9ydC5kZXZpY2VfaWQgPSBjcHVfdG9fbGUzMihwbTgwMDFfaGFfZGV2
LT5kZXZpY2VfaWQpOwogCXRhc2tfYWJvcnQudGFnID0gY3B1X3RvX2xlMzIoY2NiX3RhZyk7
CiAKKwlwbTgwMDFfc2V0X3Rhc2tfYXRfaW5pdGlhdG9yKHRhc2spOwogCXJldCA9IHBtODAw
MV9tcGlfYnVpbGRfY21kKHBtODAwMV9oYSwgY2lyY3VsYXJRLCBvcGMsICZ0YXNrX2Fib3J0
LAogCQkJc2l6ZW9mKHRhc2tfYWJvcnQpLCAwKTsKIAlpZiAocmV0KQpAQCAtMTg2OCw2ICsx
ODY5LDcgQEAgc3RhdGljIHZvaWQgcG04MDAxX3NlbmRfcmVhZF9sb2coc3RydWN0IHBtODAw
MV9oYmFfaW5mbyAqcG04MDAxX2hhLAogCXNhdGFfY21kLm5jcXRhZ19hdGFwX2Rpcl9tIHw9
ICgoMHgxIDw8IDcpIHwgKDB4NSA8PCA5KSk7CiAJbWVtY3B5KCZzYXRhX2NtZC5zYXRhX2Zp
cywgJmZpcywgc2l6ZW9mKHN0cnVjdCBob3N0X3RvX2Rldl9maXMpKTsKIAorCXBtODAwMV9z
ZXRfdGFza19hdF9pbml0aWF0b3IodGFzayk7CiAJcmVzID0gcG04MDAxX21waV9idWlsZF9j
bWQocG04MDAxX2hhLCBjaXJjdWxhclEsIG9wYywgJnNhdGFfY21kLAogCQkJc2l6ZW9mKHNh
dGFfY21kKSwgMCk7CiAJaWYgKHJlcykgewpAQCAtNDE5OCw2ICs0MjAwLDggQEAgc3RhdGlj
IGludCBwbTgwMDFfY2hpcF9zbXBfcmVxKHN0cnVjdCBwbTgwMDFfaGJhX2luZm8gKnBtODAw
MV9oYSwKIAlzbXBfY21kLmxvbmdfc21wX3JlcS5sb25nX3Jlc3Bfc2l6ZSA9CiAJCWNwdV90
b19sZTMyKCh1MzIpc2dfZG1hX2xlbigmdGFzay0+c21wX3Rhc2suc21wX3Jlc3ApLTQpOwog
CWJ1aWxkX3NtcF9jbWQocG04MDAxX2Rldi0+ZGV2aWNlX2lkLCBzbXBfY21kLnRhZywgJnNt
cF9jbWQpOworCisJcG04MDAxX3NldF90YXNrX2F0X2luaXRpYXRvcih0YXNrKTsKIAlyYyA9
IHBtODAwMV9tcGlfYnVpbGRfY21kKHBtODAwMV9oYSwgY2lyY3VsYXJRLCBvcGMsCiAJCQkm
c21wX2NtZCwgc2l6ZW9mKHNtcF9jbWQpLCAwKTsKIAlpZiAocmMpCkBAIC00MjY2LDYgKzQy
NzAsNyBAQCBzdGF0aWMgaW50IHBtODAwMV9jaGlwX3NzcF9pb19yZXEoc3RydWN0IHBtODAw
MV9oYmFfaW5mbyAqcG04MDAxX2hhLAogCQlzc3BfY21kLmxlbiA9IGNwdV90b19sZTMyKHRh
c2stPnRvdGFsX3hmZXJfbGVuKTsKIAkJc3NwX2NtZC5lc2dsID0gMDsKIAl9CisJcG04MDAx
X3NldF90YXNrX2F0X2luaXRpYXRvcih0YXNrKTsKIAlyZXQgPSBwbTgwMDFfbXBpX2J1aWxk
X2NtZChwbTgwMDFfaGEsIGNpcmN1bGFyUSwgb3BjLCAmc3NwX2NtZCwKIAkJCXNpemVvZihz
c3BfY21kKSwgMCk7CiAJcmV0dXJuIHJldDsKQEAgLTQzNzUsNiArNDM4MCw3IEBAIHN0YXRp
YyBpbnQgcG04MDAxX2NoaXBfc2F0YV9yZXEoc3RydWN0IHBtODAwMV9oYmFfaW5mbyAqcG04
MDAxX2hhLAogCQl9CiAJfQogCisJcG04MDAxX3NldF90YXNrX2F0X2luaXRpYXRvcih0YXNr
KTsKIAlyZXQgPSBwbTgwMDFfbXBpX2J1aWxkX2NtZChwbTgwMDFfaGEsIGNpcmN1bGFyUSwg
b3BjLCAmc2F0YV9jbWQsCiAJCQlzaXplb2Yoc2F0YV9jbWQpLCAwKTsKIAlyZXR1cm4gcmV0
OwpAQCAtNDY0Niw2ICs0NjUyLDcgQEAgaW50IHBtODAwMV9jaGlwX3NzcF90bV9yZXEoc3Ry
dWN0IHBtODAwMV9oYmFfaW5mbyAqcG04MDAxX2hhLAogCWlmIChwbTgwMDFfaGEtPmNoaXBf
aWQgIT0gY2hpcF84MDAxKQogCQlzc3BUTUNtZC5kc19hZHNfbSA9IDB4MDg7CiAJY2lyY3Vs
YXJRID0gJnBtODAwMV9oYS0+aW5ibmRfcV90YmxbMF07CisJcG04MDAxX3NldF90YXNrX2F0
X2luaXRpYXRvcih0YXNrKTsKIAlyZXQgPSBwbTgwMDFfbXBpX2J1aWxkX2NtZChwbTgwMDFf
aGEsIGNpcmN1bGFyUSwgb3BjLCAmc3NwVE1DbWQsCiAJCQlzaXplb2Yoc3NwVE1DbWQpLCAw
KTsKIAlyZXR1cm4gcmV0OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3BtODAwMS9wbTgw
MDFfc2FzLmMgYi9kcml2ZXJzL3Njc2kvcG04MDAxL3BtODAwMV9zYXMuYwppbmRleCBjZWMx
YWQ0N2JmNWIuLjEwNGZiNGZlMzUyNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9zY3NpL3BtODAw
MS9wbTgwMDFfc2FzLmMKKysrIGIvZHJpdmVycy9zY3NpL3BtODAwMS9wbTgwMDFfc2FzLmMK
QEAgLTQ4OCw5ICs0ODgsNiBAQCBzdGF0aWMgaW50IHBtODAwMV90YXNrX2V4ZWMoc3RydWN0
IHNhc190YXNrICp0YXNrLAogCQl9CiAJCW1kZWxheSgxMCk7CiAJCS8qIFRPRE86IHNlbGVj
dCBub3JtYWwgb3IgaGlnaCBwcmlvcml0eSAqLwotCQlzcGluX2xvY2soJnQtPnRhc2tfc3Rh
dGVfbG9jayk7Ci0JCXQtPnRhc2tfc3RhdGVfZmxhZ3MgfD0gU0FTX1RBU0tfQVRfSU5JVElB
VE9SOwotCQlzcGluX3VubG9jaygmdC0+dGFza19zdGF0ZV9sb2NrKTsKIAl9IHdoaWxlICgw
KTsKIAlyYyA9IDA7CiAJZ290byBvdXRfZG9uZTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2Nz
aS9wbTgwMDEvcG04MDAxX3Nhcy5oIGIvZHJpdmVycy9zY3NpL3BtODAwMS9wbTgwMDFfc2Fz
LmgKaW5kZXggYTE3ZGExY2ViY2UxLi5hN2RhMGNiMzVhNzcgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvc2NzaS9wbTgwMDEvcG04MDAxX3Nhcy5oCisrKyBiL2RyaXZlcnMvc2NzaS9wbTgwMDEv
cG04MDAxX3Nhcy5oCkBAIC03NDgsNSArNzQ4LDEyIEBAIHBtODAwMV9jY2JfdGFza19mcmVl
X2RvbmUoc3RydWN0IHBtODAwMV9oYmFfaW5mbyAqcG04MDAxX2hhLAogCXRhc2stPnRhc2tf
ZG9uZSh0YXNrKTsKIH0KIAorc3RhdGljIGlubGluZSB2b2lkIHBtODAwMV9zZXRfdGFza19h
dF9pbml0aWF0b3Ioc3RydWN0IHNhc190YXNrICp0KQoreworCXNwaW5fbG9jaygmdC0+dGFz
a19zdGF0ZV9sb2NrKTsKKwl0LT50YXNrX3N0YXRlX2ZsYWdzIHw9IFNBU19UQVNLX0FUX0lO
SVRJQVRPUjsKKwlzcGluX3VubG9jaygmdC0+dGFza19zdGF0ZV9sb2NrKTsKK30KKwogI2Vu
ZGlmCiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9wbTgwMDEvcG04MHh4X2h3aS5jIGIv
ZHJpdmVycy9zY3NpL3BtODAwMS9wbTgweHhfaHdpLmMKaW5kZXggMjUzMGQxMzY1NTU2Li4x
MWI5MTFmYWMyYzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9wbTgwMDEvcG04MHh4X2h3
aS5jCisrKyBiL2RyaXZlcnMvc2NzaS9wbTgwMDEvcG04MHh4X2h3aS5jCkBAIC0xODA5LDYg
KzE4MDksNyBAQCBzdGF0aWMgdm9pZCBwbTgweHhfc2VuZF9hYm9ydF9hbGwoc3RydWN0IHBt
ODAwMV9oYmFfaW5mbyAqcG04MDAxX2hhLAogCXRhc2tfYWJvcnQuZGV2aWNlX2lkID0gY3B1
X3RvX2xlMzIocG04MDAxX2hhX2Rldi0+ZGV2aWNlX2lkKTsKIAl0YXNrX2Fib3J0LnRhZyA9
IGNwdV90b19sZTMyKGNjYl90YWcpOwogCisJcG04MDAxX3NldF90YXNrX2F0X2luaXRpYXRv
cih0YXNrKTsKIAlyZXQgPSBwbTgwMDFfbXBpX2J1aWxkX2NtZChwbTgwMDFfaGEsIGNpcmN1
bGFyUSwgb3BjLCAmdGFza19hYm9ydCwKIAkJCXNpemVvZih0YXNrX2Fib3J0KSwgMCk7CiAJ
cG04MDAxX2RiZyhwbTgwMDFfaGEsIEZBSUwsICJFeGVjdXRpbmcgYWJvcnQgdGFzayBlbmRc
biIpOwpAQCAtMTg4NSw2ICsxODg2LDcgQEAgc3RhdGljIHZvaWQgcG04MHh4X3NlbmRfcmVh
ZF9sb2coc3RydWN0IHBtODAwMV9oYmFfaW5mbyAqcG04MDAxX2hhLAogCXNhdGFfY21kLm5j
cXRhZ19hdGFwX2Rpcl9tX2RhZCB8PSAoKDB4MSA8PCA3KSB8ICgweDUgPDwgOSkpOwogCW1l
bWNweSgmc2F0YV9jbWQuc2F0YV9maXMsICZmaXMsIHNpemVvZihzdHJ1Y3QgaG9zdF90b19k
ZXZfZmlzKSk7CiAKKwlwbTgwMDFfc2V0X3Rhc2tfYXRfaW5pdGlhdG9yKHRhc2spOwogCXJl
cyA9IHBtODAwMV9tcGlfYnVpbGRfY21kKHBtODAwMV9oYSwgY2lyY3VsYXJRLCBvcGMsICZz
YXRhX2NtZCwKIAkJCXNpemVvZihzYXRhX2NtZCksIDApOwogCXBtODAwMV9kYmcocG04MDAx
X2hhLCBGQUlMLCAiRXhlY3V0aW5nIHJlYWQgbG9nIGVuZFxuIik7CkBAIC00MzQyLDYgKzQz
NDQsNyBAQCBzdGF0aWMgaW50IHBtODB4eF9jaGlwX3NtcF9yZXEoc3RydWN0IHBtODAwMV9o
YmFfaW5mbyAqcG04MDAxX2hhLAogCWt1bm1hcF9hdG9taWModG8pOwogCWJ1aWxkX3NtcF9j
bWQocG04MDAxX2Rldi0+ZGV2aWNlX2lkLCBzbXBfY21kLnRhZywKIAkJCQkmc21wX2NtZCwg
cG04MDAxX2hhLT5zbXBfZXhwX21vZGUsIGxlbmd0aCk7CisJcG04MDAxX3NldF90YXNrX2F0
X2luaXRpYXRvcih0YXNrKTsKIAlyYyA9IHBtODAwMV9tcGlfYnVpbGRfY21kKHBtODAwMV9o
YSwgY2lyY3VsYXJRLCBvcGMsICZzbXBfY21kLAogCQkJc2l6ZW9mKHNtcF9jbWQpLCAwKTsK
IAlpZiAocmMpCkBAIC00NTM4LDYgKzQ1NDEsNyBAQCBzdGF0aWMgaW50IHBtODB4eF9jaGlw
X3NzcF9pb19yZXEoc3RydWN0IHBtODAwMV9oYmFfaW5mbyAqcG04MDAxX2hhLAogCQkJc3Nw
X2NtZC5lc2dsID0gMDsKIAkJfQogCX0KKwlwbTgwMDFfc2V0X3Rhc2tfYXRfaW5pdGlhdG9y
KHRhc2spOwogCXJldCA9IHBtODAwMV9tcGlfYnVpbGRfY21kKHBtODAwMV9oYSwgY2lyY3Vs
YXJRLCBvcGMsCiAJCQkmc3NwX2NtZCwgc2l6ZW9mKHNzcF9jbWQpLCBxX2luZGV4KTsKIAly
ZXR1cm4gcmV0OwpAQCAtNDc3NCw2ICs0Nzc4LDcgQEAgc3RhdGljIGludCBwbTgweHhfY2hp
cF9zYXRhX3JlcShzdHJ1Y3QgcG04MDAxX2hiYV9pbmZvICpwbTgwMDFfaGEsCiAJCQkJY2Ni
LT5jY2JfdGFnLCBvcGMsCiAJCQkJcWMgPyBxYy0+dGYuY29tbWFuZCA6IDAsIC8vIGF0YSBv
cGNvZGUKIAkJCQljY2ItPmRldmljZSA/IGF0b21pY19yZWFkKCZjY2ItPmRldmljZS0+cnVu
bmluZ19yZXEpIDogMCk7CisJcG04MDAxX3NldF90YXNrX2F0X2luaXRpYXRvcih0YXNrKTsK
IAlyZXQgPSBwbTgwMDFfbXBpX2J1aWxkX2NtZChwbTgwMDFfaGEsIGNpcmN1bGFyUSwgb3Bj
LAogCQkJJnNhdGFfY21kLCBzaXplb2Yoc2F0YV9jbWQpLCBxX2luZGV4KTsKIAlyZXR1cm4g
cmV0OwotLSAKMi4yNi4yCgo=

--------------Om3S7qykNY4xaw3MSzqO7tsA--
