Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D190653F906
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiFGJGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbiFGJF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:05:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DB37D4A26
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654592757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HhinCZb2A9zT1SaIBzoENIRctzxd17wZ4GhZVdK/SiM=;
        b=hU3HyANtOltgop5skaolvog+/GxJ/SqmNQV+QpADsIfHLpMpktb9/45VBf+yTSaDUhWB0N
        fQWmrrJ21wMyuk0rNgH7jEBEleI8PYN0uEZdH1tlY86Uye7Id73no1CKWU2PNw/jr6SvoZ
        4N6qW/+5c0XkoF7CpMUAbJMHmaOx7J0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-7MyUizEvNMiBeVAnALlY6Q-1; Tue, 07 Jun 2022 05:05:56 -0400
X-MC-Unique: 7MyUizEvNMiBeVAnALlY6Q-1
Received: by mail-lf1-f71.google.com with SMTP id p36-20020a05651213a400b004779d806c13so8503061lfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhinCZb2A9zT1SaIBzoENIRctzxd17wZ4GhZVdK/SiM=;
        b=bUJ/LSE9jTAYFe2roJj/rOveWoovFDzUeqm1qEJLQEB+89T0xfi3HFKxlfh93O5vMw
         FsBhyjNb5s4auNG1Vb5R6YOMPdDEZoky84BqSLGpe1msk0sVN+7tlIkJXSHkX+CpcycL
         wyWApMgSAZEzCqQ8o7i9O2WIScoBnBuGcTuM22/YkjrqI9R5PpxkpmpVtomhBV/lq8+R
         aT/qE5pdrYKQMB81/rnHmc9TKw3kzteebM2Loh0418VAg5UmpYa8Mxwgo9SiCw4o6Kmj
         2G2Up6IKz1YmoM1HOwl4daAAvxKKZnbfNIJDj1ezIIjzkJU97FWXvtiqyv/aL1IZiov4
         RTbg==
X-Gm-Message-State: AOAM533nlk0aSfcshi7zLRd8lCLxNAUcsOq347RQawmKVNdiwkwW1aH3
        FJfD6cSed8Ew1USFbtjVXxolkcvhDg0We0Lhsf4pNlYRCBeNV/fIo8F36rt7ZPhjLO1E/PYymuW
        LDj+HC2CV8PI0fpbSFYzQD1V1fo3VBww4w2DiuS/j
X-Received: by 2002:ac2:4e0f:0:b0:479:54a6:f9bb with SMTP id e15-20020ac24e0f000000b0047954a6f9bbmr4062060lfr.257.1654592753232;
        Tue, 07 Jun 2022 02:05:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIDIoF2LjR2OH4SEODLzhZJg0EllYDRK8WAKxmcexYZWRF7HIyxPgpDkGpn53Kll+hiDhH2iHOfgcC1b+DWMs=
X-Received: by 2002:ac2:4e0f:0:b0:479:54a6:f9bb with SMTP id
 e15-20020ac24e0f000000b0047954a6f9bbmr4062047lfr.257.1654592753037; Tue, 07
 Jun 2022 02:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fc128605e08585c6@google.com> <00000000000068486805e0d68f94@google.com>
In-Reply-To: <00000000000068486805e0d68f94@google.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 7 Jun 2022 17:05:41 +0800
Message-ID: <CACGkMEvCmtmfBSDeq1psgW4+MTymfs_T-EFQx=2UdXfy1vWDiw@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in add_early_randomness (2)
To:     syzbot <syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux@dominikbrodowski.net, mpm@selenic.com, mst <mst@redhat.com>,
        syzkaller-bugs@googlegroups.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, yuehaibing@huawei.com
Content-Type: multipart/mixed; boundary="0000000000004b57ae05e0d7e507"
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004b57ae05e0d7e507
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 7, 2022 at 3:30 PM syzbot
<syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 8b4ec69d7e098a7ddf832e1e7840de53ed474c77
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Fri May 27 06:01:19 2022 +0000
>
>     virtio: harden vring IRQ
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1175c3c7f00000
> start commit:   f2906aa86338 Linux 5.19-rc1
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1375c3c7f00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1575c3c7f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd131cc02ee620e
> dashboard link: https://syzkaller.appspot.com/bug?extid=5b59d6d459306a556f54
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104f4d4ff00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d6782df00000
>
> Reported-by: syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com
> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>

I wonder if it's related to shared IRQ.

Want to know if the attached patch works.

Thanks

--0000000000004b57ae05e0d7e507
Content-Type: application/octet-stream; 
	name="0001-virtio_ring-use-IRQ_HANDLED.patch"
Content-Disposition: attachment; 
	filename="0001-virtio_ring-use-IRQ_HANDLED.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l43xsnpi0>
X-Attachment-Id: f_l43xsnpi0

RnJvbSAyY2JlOWYwODViMTZiOGExOTE4ODFiZTg4MDgxOGQwNzA1NjQxNzhkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgpEYXRl
OiBUdWUsIDcgSnVuIDIwMjIgMTY6NTY6MjcgKzA4MDAKU3ViamVjdDogW1BBVENIXSB2aXJ0aW9f
cmluZzogdXNlIElSUV9IQU5ETEVELgpDb250ZW50LXR5cGU6IHRleHQvcGxhaW4KClNpZ25lZC1v
ZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCmluZGV4IDEzYTczNDhjZWRmZi4uMWFmNTVl
NTc2NTA1IDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCisrKyBiL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKQEAgLTIxMzcsNyArMjEzNyw3IEBAIGlycXJldHVy
bl90IHZyaW5nX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpfdnEpCiAJaWYgKHVubGlrZWx5KHZx
LT5icm9rZW4pKSB7CiAJCWRldl93YXJuX29uY2UoJnZxLT52cS52ZGV2LT5kZXYsCiAJCQkgICAg
ICAidmlydGlvIHZyaW5nIElSUSByYWlzZWQgYmVmb3JlIERSSVZFUl9PSyIpOwotCQlyZXR1cm4g
SVJRX05PTkU7CisJCXJldHVybiBJUlFfSEFORExFRDsKIAl9CiAKIAkvKiBKdXN0IGEgaGludCBm
b3IgcGVyZm9ybWFuY2U6IHNvIGl0J3Mgb2sgdGhhdCB0aGlzIGNhbiBiZSByYWN5ISAqLwotLSAK
Mi4yNS4xCgo=
--0000000000004b57ae05e0d7e507--

