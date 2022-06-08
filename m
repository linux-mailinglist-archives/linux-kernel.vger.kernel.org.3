Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5585421C5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiFHFdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiFHFdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDE1A182B8E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 20:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654657201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o9McAYyWrsI7+XrO88AfsC7QgQhcnSZ/OO2ziHkinDQ=;
        b=WpVEUo8aVTTodwvQXx0XGSQl+83nuKS9g+L7I70xsrEb6ErvLjBbW4ftqpbfSUqqrqhnl6
        qM0ow0TxgVAGj5rPWcUKyFIc9ZDSqXT9MTGwGCFsIXw+bII8/G4k0CwBCkT5u6qv+nu8eA
        LcNS/0xhLmPF0x4bHgSgsliWz3tJJbo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-0ELA241hM_aUcmUTm3LZhA-1; Tue, 07 Jun 2022 22:56:40 -0400
X-MC-Unique: 0ELA241hM_aUcmUTm3LZhA-1
Received: by mail-lf1-f72.google.com with SMTP id n3-20020ac242c3000000b00473d8af3a0cso9614284lfl.21
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 19:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9McAYyWrsI7+XrO88AfsC7QgQhcnSZ/OO2ziHkinDQ=;
        b=5IqOZVdDJ8xLWx8Pxl1MZ/96CjQLNwQnFa1xMVobPL/ItW0CuJNhVRVNVHriYib8fm
         bSsrXPkm+2NJN7JwZezUWOINOzIOQjan/5wZGerdpHH1zFC1oHBYefLzMpee+X84ChQe
         fahFTk4DoLm/7hpb8VBzhT4VR3ri0B/eyn1UZdXtv2icN3DZgMEzXzqbw1ziUsYUJqkX
         G8q5cWp5117aYER7apXw6E0iLSqHH4JzLkiBMIFe4tZDND2XFz3QtORrOT+kpsSWiDkv
         4JSen8h9ZpEn64JweS1O/PvTM1kkeMiIemL+cpEfYF8BnWZrWgfeoPX3yZ1EAH/kJqAN
         UZ2A==
X-Gm-Message-State: AOAM532OtbEbMDd68wwuwr3lSmzpfBdlPoIIpkXanY3CqmYmrfpoqXAg
        tlMV1sxXwsXFIkG4hSePGlzwpNbqW4isFwsUJ6MTSNiKPlRbPuOseTDLIsfI8MW7Ad4d6oHgW9F
        3WZ3wexwd2fVosy4eqHgclQD3kfTHMULdpqU0u1Rz
X-Received: by 2002:a2e:8803:0:b0:255:8be7:c03a with SMTP id x3-20020a2e8803000000b002558be7c03amr10347911ljh.487.1654656999058;
        Tue, 07 Jun 2022 19:56:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpwlVlusCpTp6NggsmnXc60yNs5Trs/9dEyzHxZAW6H40JwHlEwqZA7wMR5a30UZjsruSa2N8LBHxrE0fJAvw=
X-Received: by 2002:a2e:8803:0:b0:255:8be7:c03a with SMTP id
 x3-20020a2e8803000000b002558be7c03amr10347902ljh.487.1654656998884; Tue, 07
 Jun 2022 19:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEvtV+hVdpgpkYvAmkRteYDN+2dDacrfXsYDv0ZzjJU+ag@mail.gmail.com>
 <000000000000e7c46e05e0e6c6a1@google.com>
In-Reply-To: <000000000000e7c46e05e0e6c6a1@google.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 8 Jun 2022 10:56:27 +0800
Message-ID: <CACGkMEus=RMMcDk+sM8X14=AtFjK+-3p_Lo=O6tfv9H=0wXENw@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in add_early_randomness (2)
To:     syzbot <syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux@dominikbrodowski.net, mpm@selenic.com, mst <mst@redhat.com>,
        syzkaller-bugs@googlegroups.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, yuehaibing@huawei.com
Content-Type: multipart/mixed; boundary="000000000000a52a1005e0e6da20"
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a52a1005e0e6da20
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 8, 2022 at 10:51 AM syzbot
<syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> checking file drivers/char/hw_random/virtio-rng.c
> patch: **** unexpected end of file in patch
>
>

It looks like something is wrong in my email client.

Let's try with attachment.

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next

--000000000000a52a1005e0e6da20
Content-Type: application/x-patch; 
	name="0001-virtio-rng-make-device-ready-before-making-request.patch"
Content-Disposition: attachment; 
	filename="0001-virtio-rng-make-device-ready-before-making-request.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l45008iv0>
X-Attachment-Id: f_l45008iv0

RnJvbSA3Mzc2MTY1ZmM5ZmFiNzFkOWE5ZmMwZGU5MGJlMDBkYmExMjNkODc5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgpEYXRl
OiBXZWQsIDggSnVuIDIwMjIgMTA6MzM6MjggKzA4MDAKU3ViamVjdDogW1BBVENIXSB2aXJ0aW8t
cm5nOiBtYWtlIGRldmljZSByZWFkeSBiZWZvcmUgbWFraW5nIHJlcXVlc3QKQ29udGVudC10eXBl
OiB0ZXh0L3BsYWluCgpTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgotLS0KIGRyaXZlcnMvY2hhci9od19yYW5kb20vdmlydGlvLXJuZy5jIHwgMiArKwogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9o
d19yYW5kb20vdmlydGlvLXJuZy5jIGIvZHJpdmVycy9jaGFyL2h3X3JhbmRvbS92aXJ0aW8tcm5n
LmMKaW5kZXggZTg1NmRmN2UyODVjLi5hNmYzYThhMmFjYTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Y2hhci9od19yYW5kb20vdmlydGlvLXJuZy5jCisrKyBiL2RyaXZlcnMvY2hhci9od19yYW5kb20v
dmlydGlvLXJuZy5jCkBAIC0xNTksNiArMTU5LDggQEAgc3RhdGljIGludCBwcm9iZV9jb21tb24o
c3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCiAJCWdvdG8gZXJyX2ZpbmQ7CiAJfQogCisJdmly
dGlvX2RldmljZV9yZWFkeSh2ZGV2KTsKKwogCS8qIHdlIGFsd2F5cyBoYXZlIGEgcGVuZGluZyBl
bnRyb3B5IHJlcXVlc3QgKi8KIAlyZXF1ZXN0X2VudHJvcHkodmkpOwogCi0tIAoyLjI1LjEKCg==
--000000000000a52a1005e0e6da20--

