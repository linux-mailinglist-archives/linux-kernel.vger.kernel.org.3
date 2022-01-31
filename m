Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16DE4A4A87
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359303AbiAaP3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:29:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235828AbiAaP3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:29:22 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VEa3Ob018840;
        Mon, 31 Jan 2022 15:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7ij/4KgUmBUULDmuyBQmt6PQbbst4JWXNyQbqTwaPxM=;
 b=Fugr640tdrxc4WF59pRZw0pryU0rNtlOdZ3zUBmVEKeqR2qow4HtxUj3nFW3Q2hN9M0Q
 Qr7U2uQHquiZ5cjiflDR9lUjYk7vmze6Wp0dKzaDpn2yf5LgHC9e5M6zB6wzkOYchQKI
 gfJswsmUucO5vYbAAyVcss9CYnqrSyvrMRtmqs3EJDyTH0tvRLS9buNtWLqnGi1MSclc
 gPVH8eMTqS8LwTJB17she7RymnoorKuZtmLkKuIm5xMIFyNhiZZp4SAQugoJZQ0K5jXK
 a+LINFo2wSc5yUm9dr9KzLXBP/IcwUqZS6Hs2EEtsg9RpqLh/XCqaMTb+kts49oBgYFI Eg== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxfdp4ku8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:29:13 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20VFSJeo027908;
        Mon, 31 Jan 2022 15:29:12 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 3dvw7a5nhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:29:12 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20VFTBBv35258818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 15:29:11 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42E1FBE051;
        Mon, 31 Jan 2022 15:29:11 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C53EEBE054;
        Mon, 31 Jan 2022 15:29:10 +0000 (GMT)
Received: from [9.211.52.1] (unknown [9.211.52.1])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jan 2022 15:29:10 +0000 (GMT)
Message-ID: <3897c432-4365-7c54-b336-7331bb328350@linux.ibm.com>
Date:   Mon, 31 Jan 2022 09:29:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fsi: occ: Improve response status checking
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <alistair@popple.id.au>,
        Jeremy Kerr <jk@ozlabs.org>
References: <20220110155827.13976-1-eajames@linux.ibm.com>
 <CACPK8XdgOYTwy5aOQgSuSJaQUjxnobN2c3ph=dkAcWYJDVbN+w@mail.gmail.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CACPK8XdgOYTwy5aOQgSuSJaQUjxnobN2c3ph=dkAcWYJDVbN+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JfPAq0jsrDqBjzCsRDgfJjlDL6gpXCgX
X-Proofpoint-GUID: JfPAq0jsrDqBjzCsRDgfJjlDL6gpXCgX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_06,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/30/22 23:56, Joel Stanley wrote:
> On Mon, 10 Jan 2022 at 15:58, Eddie James <eajames@linux.ibm.com> wrote:
>> If the driver sequence number coincidentally equals the previous
>> command response sequence number, the driver may proceed with
>> fetching the entire buffer before the OCC has processed the current
>> command. To be sure the correct response is obtained, check the
>> command type and also retry if any of the response parameters have
>> changed when the rest of the buffer is fetched.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/fsi/fsi-occ.c | 63 ++++++++++++++++++++++++++++++-------------
>>   1 file changed, 44 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
>> index 7eaab1be0aa4..67569282dd69 100644
>> --- a/drivers/fsi/fsi-occ.c
>> +++ b/drivers/fsi/fsi-occ.c
>> @@ -451,6 +451,15 @@ static int occ_trigger_attn(struct occ *occ)
>>          return rc;
>>   }
>>
>> +static void fsi_occ_print_timeout(struct occ *occ, struct occ_response *resp,
>> +                                 u8 seq_no, u8 cmd_type)
>> +{
>> +       dev_err(occ->dev,
>> +               "resp timeout status=%02x seq=%d cmd=%d, our seq=%d cmd=%d\n",
>> +               resp->return_status, resp->seq_no, resp->cmd_type, seq_no,
>> +               cmd_type);
>> +}
>> +
>>   int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>>                     void *response, size_t *resp_len)
>>   {
>> @@ -461,12 +470,14 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>>          struct occ_response *resp = response;
>>          size_t user_resp_len = *resp_len;
>>          u8 seq_no;
>> +       u8 cmd_type;
>>          u16 checksum = 0;
>>          u16 resp_data_length;
>>          const u8 *byte_request = (const u8 *)request;
>> -       unsigned long start;
>> +       unsigned long end;
>>          int rc;
>>          size_t i;
>> +       bool retried = false;
>>
>>          *resp_len = 0;
>>
>> @@ -478,6 +489,8 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>>                  return -EINVAL;
>>          }
>>
>> +       cmd_type = byte_request[1];
>> +
>>          /* Checksum the request, ignoring first byte (sequence number). */
>>          for (i = 1; i < req_len - 2; ++i)
>>                  checksum += byte_request[i];
>> @@ -509,30 +522,30 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>>          if (rc)
>>                  goto done;
>>
>> -       /* Read occ response header */
>> -       start = jiffies;
>> +retry:
>> +       end = jiffies + timeout;
>>          do {
>> +               /* Read occ response header */
>>                  rc = occ_getsram(occ, 0, resp, 8);
>>                  if (rc)
>>                          goto done;
>>
>>                  if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
>>                      resp->return_status == OCC_RESP_CRIT_INIT ||
>> -                   resp->seq_no != seq_no) {
>> -                       rc = -ETIMEDOUT;
>> -
>> -                       if (time_after(jiffies, start + timeout)) {
>> -                               dev_err(occ->dev, "resp timeout status=%02x "
>> -                                       "resp seq_no=%d our seq_no=%d\n",
>> -                                       resp->return_status, resp->seq_no,
>> -                                       seq_no);
>> +                   resp->seq_no != seq_no || resp->cmd_type != cmd_type) {
> You're testing for two different types of conditions. The first is
> when the SBE is busy doing something else:
>
>                  if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
>                       resp->return_status == OCC_RESP_CRIT_INIT ||
>
> And the others are when the message is not for the current user:
>
>                        resp->seq_no != seq_no || resp->cmd_type != cmd_type) {
>
> Should we be separating them out? It makes sense that the first means
> we should keep trying. For the second case should we bail straight
> away, instead of waiting for the timeout?


They're really the same thing actually. If the sequence number or 
command type is incorrect, it means the OCC is processing a different 
command, and we need to wait for it to get to our command.


>
> How often do we see one vs the other?
>
>> +                       if (time_after(jiffies, end)) {
>> +                               fsi_occ_print_timeout(occ, resp, seq_no,
>> +                                                     cmd_type);
>> +                               rc = -ETIMEDOUT;
>>                                  goto done;
>>                          }
>>
>>                          set_current_state(TASK_UNINTERRUPTIBLE);
>>                          schedule_timeout(wait_time);
>> +               } else {
>> +                       break;
>>                  }
>> -       } while (rc);
>> +       } while (true);
> Use while (true) instead of do { } while (true) to make it clearer
> what's going on. Or refactor it to put the time_after in the while(),
> as this is what the loop is waiting on.


OK, I went in circles (pun intended) working on this loop, but I'll try 
and make it look better.


>
>>          /* Extract size of response data */
>>          resp_data_length = get_unaligned_be16(&resp->data_length);
>> @@ -543,17 +556,29 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>>                  goto done;
>>          }
>>
>> -       dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
>> -               resp->return_status, resp_data_length);
>> -
>> -       /* Grab the rest */
>> +       /* Now get the entire response; get header again in case it changed */
>>          if (resp_data_length > 1) {
>> -               /* already got 3 bytes resp, also need 2 bytes checksum */
>> -               rc = occ_getsram(occ, 8, &resp->data[3], resp_data_length - 1);
>> +               rc = occ_getsram(occ, 0, resp, resp_data_length + 7);
>>                  if (rc)
>>                          goto done;
>> +
>> +               if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
>> +                   resp->return_status == OCC_RESP_CRIT_INIT ||
>> +                   resp->seq_no != seq_no || resp->cmd_type != cmd_type) {
>> +                       if (!retried) {
>> +                               retried = true;
>> +                               goto retry;
> Not sure about this.
>
> How often did this situation come up?
>
> Did you consider instead returning an error here?


Well I can't say it's frequent, but hitting this condition was what 
drove making this change in the first place. It needs to be handled.

Previously if this occurrred, we got a checksum error, so it effectively 
already returned an error.


>
>> +                       }
>> +
>> +                       fsi_occ_print_timeout(occ, resp, seq_no, cmd_type);
>> +                       rc = -ETIMEDOUT;
>> +                       goto done;
>> +               }
>>          }
>>
>> +       dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
>> +               resp->return_status, resp_data_length);
>> +
>>          occ->client_response_size = resp_data_length + 7;
>>          rc = occ_verify_checksum(occ, resp, resp_data_length);
>>
>> @@ -598,7 +623,7 @@ static int occ_probe(struct platform_device *pdev)
>>          occ->version = (uintptr_t)of_device_get_match_data(dev);
>>          occ->dev = dev;
>>          occ->sbefifo = dev->parent;
>> -       occ->sequence_number = 1;
>> +       occ->sequence_number = (u8)((jiffies % 0xff) + 1);
> This is interesting. You didn't mention this in the commit message;
> you're trying to get a random number for the sequence number?


Yea, this reduces the chances of hitting that retry above. If it's 
always 1, then every time the driver is bound it tries the first command 
with the same sequence number. This is a problem when FSI scanning with 
the host already running, as the driver gets unbound/rebound several 
times in a row, and we easily hit the checksum problem, since we proceed 
to get the full response even though it's not for the latest command, 
and then the buffer is updated at the same time. So using a non-zero 
random number is very helpful.


Thanks,

Eddie


>
>>          mutex_init(&occ->occ_lock);
>>
>>          if (dev->of_node) {
>> --
>> 2.27.0
>>
