Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E454BE25D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377319AbiBUOK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:10:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiBUOKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:10:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 840561DA5D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645452597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uKHVh9Z94yUrShz6jz/jud/UHdW+Vl8hIXJM4xAQvuw=;
        b=BZYTdzVzJIpFJZJh4uPTKcJNuyEwDso2gTCzAVgtsZLtjDXjhM6iQml5/dBaN7DERZYEJ7
        oyxzbvRXaPQtG4gh6odKc05jOkKsjoo+7QpzYLqyJZZrMjorhkYnowESJMzLcqG4F1S+NA
        qP0S5gz1yzZdUQRRGjfeU8iTKwUVbCw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-5kn3xk2TNbaWXkbAKfr78g-1; Mon, 21 Feb 2022 09:09:55 -0500
X-MC-Unique: 5kn3xk2TNbaWXkbAKfr78g-1
Received: by mail-lj1-f199.google.com with SMTP id 6-20020a2eb946000000b002463d2915d2so1783293ljs.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKHVh9Z94yUrShz6jz/jud/UHdW+Vl8hIXJM4xAQvuw=;
        b=l6Vo8zX/xoa6qfxjG5EQdqhnWrs1tlFwXka000ZI3Wd6knjVtzTcpqZof2cwTAKI23
         6WQ2DgF/I26QvomqQ/R00iGl6DlRnCHF3IqPn5XazXoCTB+OwD5JOLoYdibH5KA56eDp
         8JaOYCbaMFruiTisGRL02F2gMcmMA1BP33LyCkNMjeFOEEVoldi8Bk38ZL57X3afssB+
         OAiElnZ2vWOyyDLEolg1un663m5njj8St4w2HTyR26bT3rMYQJnLNCnKKNJJwdJdryrs
         3oj47xlJSsZcHpmqCeoXZg8IWp59E6GjsoM6K7gr4A6JTA5U5XFnvEZQjL24Ow/737Xq
         54KA==
X-Gm-Message-State: AOAM531G86vmFRhXHsI4KOz1NWjPujfc9swkLy5rOmmCkSIPgU/XIsFy
        2RRrjbGFjOZcslhNBobzFLnvq0puOch0ioGDHNbRiV1BJzQt+1QB3Dpsbl9sKxeokNVYVcJLdXa
        OeVFFs7MQdVdKabSgY1haGKNoqV164q6AoFwDobs7
X-Received: by 2002:a2e:87d3:0:b0:244:c1ab:91ae with SMTP id v19-20020a2e87d3000000b00244c1ab91aemr14441216ljj.277.1645452594410;
        Mon, 21 Feb 2022 06:09:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytAjOQhsA6zk+E+uwdNU8NYVnT8FykWe3yh7j+XcyaZrCUQw0HwtUmBBjUDuA7J2YSCQ7v1CVP4SiW3Ue5e28=
X-Received: by 2002:a2e:87d3:0:b0:244:c1ab:91ae with SMTP id
 v19-20020a2e87d3000000b00244c1ab91aemr14441196ljj.277.1645452594151; Mon, 21
 Feb 2022 06:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20220220014715.921-1-hdanton@sina.com> <0000000000007675d105d8699d01@google.com>
In-Reply-To: <0000000000007675d105d8699d01@google.com>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Mon, 21 Feb 2022 15:09:42 +0100
Message-ID: <CAGxU2F4f0Gx=-4g-r3QHFPsn0WwSW3HyT+MRKj4=TTWp9R+WYw@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
To:     syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>
Cc:     Hillf Danton <hdanton@sina.com>, Jason Wang <jasowang@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Michael Tsirkin <mst@redhat.com>,
        syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="0000000000005eb7b705d887c936"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005eb7b705d887c936
Content-Type: text/plain; charset="UTF-8"

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
f71077a4d84b

Patch sent upstream:
https://lore.kernel.org/virtualization/20220221114916.107045-1-sgarzare@redhat.com/T/#u

On Sun, Feb 20, 2022 at 3:11 AM syzbot
<syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Reported-and-tested-by: syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
> dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=143dc0d4700000
>
> Note: testing is done by a robot and is best-effort only.
>

--0000000000005eb7b705d887c936
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-vhost-vsock-don-t-check-owner-in-vhost_vsock_stop-wh.patch"
Content-Disposition: attachment; 
	filename="0001-vhost-vsock-don-t-check-owner-in-vhost_vsock_stop-wh.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kzwry4570>
X-Attachment-Id: f_kzwry4570

RnJvbSA0OTUxMTEyYmY5OGQzZTEwZDNlOTU1Nzk4NmU1Y2E1NDE5Y2E3MzhmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5j
b20+CkRhdGU6IE1vbiwgMjEgRmViIDIwMjIgMTE6MDc6NDkgKzAxMDAKU3ViamVjdDogW1BBVENI
XSB2aG9zdC92c29jazogZG9uJ3QgY2hlY2sgb3duZXIgaW4gdmhvc3RfdnNvY2tfc3RvcCgpIHdo
aWxlCiByZWxlYXNpbmcKCnZob3N0X3Zzb2NrX3N0b3AoKSBjYWxscyB2aG9zdF9kZXZfY2hlY2tf
b3duZXIoKSB0byBjaGVjayB0aGUgZGV2aWNlCm93bmVyc2hpcC4gSXQgZXhwZWN0cyBjdXJyZW50
LT5tbSB0byBiZSB2YWxpZC4KCnZob3N0X3Zzb2NrX3N0b3AoKSBpcyBhbHNvIGNhbGxlZCBieSB2
aG9zdF92c29ja19kZXZfcmVsZWFzZSgpIHdoZW4KdGhlIHVzZXIgaGFzIG5vdCBkb25lIGNsb3Nl
KCksIHNvIHdoZW4gd2UgYXJlIGluIGRvX2V4aXQoKS4gSW4gdGhpcwpjYXNlIGN1cnJlbnQtPm1t
IGlzIGludmFsaWQgYW5kIHdlJ3JlIHJlbGVhc2luZyB0aGUgZGV2aWNlLCBzbyB3ZQpzaG91bGQg
Y2xlYW4gaXQgYW55d2F5LgoKTGV0J3MgY2hlY2sgdGhlIG93bmVyIG9ubHkgd2hlbiB2aG9zdF92
c29ja19zdG9wKCkgaXMgY2FsbGVkCmJ5IGFuIGlvY3RsLgoKRml4ZXM6IDQzM2ZjNThlNmJmMiAo
IlZTT0NLOiBJbnRyb2R1Y2Ugdmhvc3RfdnNvY2sua28iKQpDYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZwpSZXBvcnRlZC1ieTogc3l6Ym90KzFlM2VhNjNkYjM5ZjJiNDQ0MGUwQHN5emthbGxlci5h
cHBzcG90bWFpbC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFy
ZUByZWRoYXQuY29tPgotLS0KIGRyaXZlcnMvdmhvc3QvdnNvY2suYyB8IDE0ICsrKysrKysrLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdnNvY2suYyBiL2RyaXZlcnMvdmhvc3QvdnNvY2suYwpp
bmRleCBkNmNhMWM3YWQ1MTMuLmYwMGQyZGZkNzJiNyAxMDA2NDQKLS0tIGEvZHJpdmVycy92aG9z
dC92c29jay5jCisrKyBiL2RyaXZlcnMvdmhvc3QvdnNvY2suYwpAQCAtNjI5LDE2ICs2MjksMTgg
QEAgc3RhdGljIGludCB2aG9zdF92c29ja19zdGFydChzdHJ1Y3Qgdmhvc3RfdnNvY2sgKnZzb2Nr
KQogCXJldHVybiByZXQ7CiB9CiAKLXN0YXRpYyBpbnQgdmhvc3RfdnNvY2tfc3RvcChzdHJ1Y3Qg
dmhvc3RfdnNvY2sgKnZzb2NrKQorc3RhdGljIGludCB2aG9zdF92c29ja19zdG9wKHN0cnVjdCB2
aG9zdF92c29jayAqdnNvY2ssIGJvb2wgY2hlY2tfb3duZXIpCiB7CiAJc2l6ZV90IGk7CiAJaW50
IHJldDsKIAogCW11dGV4X2xvY2soJnZzb2NrLT5kZXYubXV0ZXgpOwogCi0JcmV0ID0gdmhvc3Rf
ZGV2X2NoZWNrX293bmVyKCZ2c29jay0+ZGV2KTsKLQlpZiAocmV0KQotCQlnb3RvIGVycjsKKwlp
ZiAoY2hlY2tfb3duZXIpIHsKKwkJcmV0ID0gdmhvc3RfZGV2X2NoZWNrX293bmVyKCZ2c29jay0+
ZGV2KTsKKwkJaWYgKHJldCkKKwkJCWdvdG8gZXJyOworCX0KIAogCWZvciAoaSA9IDA7IGkgPCBB
UlJBWV9TSVpFKHZzb2NrLT52cXMpOyBpKyspIHsKIAkJc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAq
dnEgPSAmdnNvY2stPnZxc1tpXTsKQEAgLTc1Myw3ICs3NTUsNyBAQCBzdGF0aWMgaW50IHZob3N0
X3Zzb2NrX2Rldl9yZWxlYXNlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxl
KQogCSAqIGluZWZmaWNpZW50LiAgUm9vbSBmb3IgaW1wcm92ZW1lbnQgaGVyZS4gKi8KIAl2c29j
a19mb3JfZWFjaF9jb25uZWN0ZWRfc29ja2V0KHZob3N0X3Zzb2NrX3Jlc2V0X29ycGhhbnMpOwog
Ci0Jdmhvc3RfdnNvY2tfc3RvcCh2c29jayk7CisJdmhvc3RfdnNvY2tfc3RvcCh2c29jaywgZmFs
c2UpOwogCXZob3N0X3Zzb2NrX2ZsdXNoKHZzb2NrKTsKIAl2aG9zdF9kZXZfc3RvcCgmdnNvY2st
PmRldik7CiAKQEAgLTg2OCw3ICs4NzAsNyBAQCBzdGF0aWMgbG9uZyB2aG9zdF92c29ja19kZXZf
aW9jdGwoc3RydWN0IGZpbGUgKmYsIHVuc2lnbmVkIGludCBpb2N0bCwKIAkJaWYgKHN0YXJ0KQog
CQkJcmV0dXJuIHZob3N0X3Zzb2NrX3N0YXJ0KHZzb2NrKTsKIAkJZWxzZQotCQkJcmV0dXJuIHZo
b3N0X3Zzb2NrX3N0b3AodnNvY2spOworCQkJcmV0dXJuIHZob3N0X3Zzb2NrX3N0b3AodnNvY2ss
IHRydWUpOwogCWNhc2UgVkhPU1RfR0VUX0ZFQVRVUkVTOgogCQlmZWF0dXJlcyA9IFZIT1NUX1ZT
T0NLX0ZFQVRVUkVTOwogCQlpZiAoY29weV90b191c2VyKGFyZ3AsICZmZWF0dXJlcywgc2l6ZW9m
KGZlYXR1cmVzKSkpCi0tIAoyLjM1LjEKCg==
--0000000000005eb7b705d887c936--

