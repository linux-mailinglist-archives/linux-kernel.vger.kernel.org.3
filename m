Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B60553083A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 06:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiEWEPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 00:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiEWEPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 00:15:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5763D140BC
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 21:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653279337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4uq0rZJkoN6vEvVqkAPhz7EjjSM0bnK2nRK5G7D8m8=;
        b=E06ZiPUoP/hqPw0e2teBzRZIyydDtVfLpTf8Z3IKyPsq/879GsvTtVsweXZRoA+XCg/9Nu
        iRKGlAJv7JkyBL008TqvLFsGrd5zD4KLAYYJYlELwM53rf854pEk/MAwnAyA5qmyAjyydo
        fjpwQClzulF91QkRPPHBjQ1mNW9Pj00=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-7rVsvg41MA-alehKj2j6OQ-1; Mon, 23 May 2022 00:15:29 -0400
X-MC-Unique: 7rVsvg41MA-alehKj2j6OQ-1
Received: by mail-lj1-f199.google.com with SMTP id d2-20020a2e8902000000b00253bba7ce10so2564516lji.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 21:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4uq0rZJkoN6vEvVqkAPhz7EjjSM0bnK2nRK5G7D8m8=;
        b=yzA5kRxIZK5nB5WhLQpwoSvLeP49MvuwtvbcWI3dajUgkiP9XrG+g1Si+afQtALjb8
         Al7WgESriXPT39OokDMOZP1wkPDE+h5gnetbbLevFuS+jPdJo6dnx+UVJRgY3liwc7UT
         8KLbSny2A5GNGNos0fVaKfWUm38icMSsHLYUk1qB452jJkOxr79icyhK7nf1f1u/Q3xv
         LT6dGXW88YYj1eYuwlIaR/PBkYoocP8ngu1CnGd0RiPOTHRbwZ5vPECLMzNerYR2rTFz
         E5fQi5cdA4vLCIemxb8G482Y3eiO3lkO15eHsSjU18rSonvJSdJfCktAADE86gIS7a8Q
         HulQ==
X-Gm-Message-State: AOAM533/vI6daOGltvPtakXVOwVr+RdhM24762cdYQXT6zOxyVZCJehl
        AhbG0u0fO3ksaoFCyqrM3mdCPvqJNXyS2IfzV1ve9ZRAGGcDAjEpHegBLX59nvPNhRDPJr9C1s+
        YkuHLjSRuJTifAAizXxj4cfZFjXuWvnVgZMIwV7IO
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id p21-20020a056512139500b00446d38279a5mr14947651lfa.210.1653279328291;
        Sun, 22 May 2022 21:15:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWmvbbOnlzByyq0K7ST1/0Rig6zYncXxT7uN0bhy7BAXium/pYbfOxxsbqwsJyyqfJa8HBFvtAlbjEDB8k180=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr14947643lfa.210.1653279328132; Sun, 22
 May 2022 21:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBj=5jD5AjyaF8UmMXAZGFnMEgTruFM2KYL3GGZt-ABcHBQ@mail.gmail.com>
In-Reply-To: <CAMhUBj=5jD5AjyaF8UmMXAZGFnMEgTruFM2KYL3GGZt-ABcHBQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 23 May 2022 12:15:16 +0800
Message-ID: <CACGkMEvgtzUXw9v=cMN3=Mqm9YTp_2bKmc4--q2+BREvgVdeLg@mail.gmail.com>
Subject: Re: [BUG] vDPA/ifcvf: got a warning when removing the module
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     mst <mst@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
        Yongji Xie <xieyongji@bytedance.com>,
        Eli Cohen <elic@nvidia.com>, Parav Pandit <parav@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000001188a805dfa6171f"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001188a805dfa6171f
Content-Type: text/plain; charset="UTF-8"

On Sat, May 21, 2022 at 10:27 PM Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> Hello,
>
> I found a bug in the ifcvf driver.
> When removing the module, I got the following warning:
>
> [   14.478123] general protection fault, probably for non-canonical
> address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
> [   14.478701] KASAN: null-ptr-deref in range
> [0x0000000000000028-0x000000000000002f]
> [   14.479922] RIP: 0010:vdpa_mgmtdev_unregister+0x39/0x150
> [   14.484063] Call Trace:
> [   14.484186]  <TASK>
> [   14.484292]  ? _raw_spin_unlock_irqrestore+0x3d/0x60
> [   14.484536]  ifcvf_remove+0x3a/0x50 [ifcvf]
> [   14.484743]  pci_device_remove+0x92/0x240
>
> The reason is that the 'ifcvf_mgmt_dev' is zero which means that
> ifcvf_vdpa_dev_add() was not executed.
> Since I am not familiar with the driver, I cannot find a proper solution for it.
>

Looks like the drv data needs to be set in probe(). Could you pleas
try to the attached patch? (compile test only).

Thanks

> Zheyu Ma
>

--0000000000001188a805dfa6171f
Content-Type: application/octet-stream; 
	name="0001-vdpa-ifcvf-set-pci-driver-data-in-probe.patch"
Content-Disposition: attachment; 
	filename="0001-vdpa-ifcvf-set-pci-driver-data-in-probe.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l3i7tfc30>
X-Attachment-Id: f_l3i7tfc30

RnJvbSBjN2MwMzFkMWE1YzY0ZTBmNThlMDE1NzlmZjc4MjI0YTU4ZDZhNGZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgpEYXRl
OiBNb24sIDIzIE1heSAyMDIyIDEyOjEyOjAwICswODAwClN1YmplY3Q6IFtQQVRDSF0gdmRwYTog
aWZjdmY6IHNldCBwY2kgZHJpdmVyIGRhdGEgaW4gcHJvYmUKQ29udGVudC10eXBlOiB0ZXh0L3Bs
YWluCgpXZSBzaG91bGQgc2V0IHRoZSBwY2kgZHJpdmVyIGRhdGEgaW4gcHJvYmUgaW5zdGVhZCBv
ZiB0aGUgdmRwYSBkZXZpY2UKYWRkaW5nIGNhbGxiYWNrLiBPdGhlcndpc2UgaWYgbm8gdkRQQSBk
ZXZpY2UgaXMgY3JlYXRlZCB3ZSB3aWxsIGxvc2UKdGhlIHBvaW50ZXIgdG8gdGhlIG1hbmFnZW1l
bnQgZGV2aWNlLgoKRml4ZXM6IDZiNWRmMzQ3YzY0ODIgKCJ2RFBBL2lmY3ZmOiBpbXBsZW1lbnQg
bWFuYWdlbWVudCBuZXRsaW5rIGZyYW1ld29yayBmb3IgaWZjdmYiKQpTaWduZWQtb2ZmLWJ5OiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgotLS0KIGRyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMg
Yi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCmluZGV4IDQzNjYzMjBmYjY4ZC4uMTk3
ZDUyZTdiODAxIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCisr
KyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKQEAgLTc2NSw3ICs3NjUsNiBAQCBz
dGF0aWMgaW50IGlmY3ZmX3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldiwg
Y29uc3QgY2hhciAqbmFtZSwKIAl9CiAKIAlpZmN2Zl9tZ210X2Rldi0+YWRhcHRlciA9IGFkYXB0
ZXI7Ci0JcGNpX3NldF9kcnZkYXRhKHBkZXYsIGlmY3ZmX21nbXRfZGV2KTsKIAogCXZmID0gJmFk
YXB0ZXItPnZmOwogCXZmLT5kZXZfdHlwZSA9IGdldF9kZXZfdHlwZShwZGV2KTsKQEAgLTg4MCw2
ICs4NzksOCBAQCBzdGF0aWMgaW50IGlmY3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBj
b25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCiAJCWdvdG8gZXJyOwogCX0KIAorCXBjaV9z
ZXRfZHJ2ZGF0YShwZGV2LCBpZmN2Zl9tZ210X2Rldik7CisKIAlyZXR1cm4gMDsKIAogZXJyOgot
LSAKMi4yNS4xCgo=
--0000000000001188a805dfa6171f--

