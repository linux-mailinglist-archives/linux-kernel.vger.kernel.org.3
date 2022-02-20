Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6730C4BCF9D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbiBTPo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:44:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiBTPoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:44:55 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835F542A19;
        Sun, 20 Feb 2022 07:44:33 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id v28so3782203ljv.9;
        Sun, 20 Feb 2022 07:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to;
        bh=IcItXc+sNrCk2+Q4Jyfa3crAb0rYqmVxEFy4N4i47uU=;
        b=RI1owrYqtNeZRwrAKKfUgRot+GcPpwydXGZXta9gNZfGegbchDMEgmkfTobvff9XOa
         ztoU7p0V++IDCzv/9sgAK2hJXfPBb+BJQ57KrT5TOjfsI162Ddj4CUQxEtGviivvt72s
         XK5kMP+hG+0kr6q4WtvC5s7VJHGs006bICQSlOxRFDL1BexOAo9y9YZY08DcfTgip8uY
         ARzPRY2o1WD5SpY1cNGZ2M8y1h3ouh3fZVN6+K0hNrtzUVcsfJQkMSd/3Yn+hJ/u3NmG
         OQC5K907g8q1d/Z4dFlTt1TB0tRIjpvW+x4nTr4/4ZRTvWeTksRPlvswzLOjb1bFIYNy
         DK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to;
        bh=IcItXc+sNrCk2+Q4Jyfa3crAb0rYqmVxEFy4N4i47uU=;
        b=l0A71zM+0sGWAdLvrlE4HJS0endShJFn8H4j2or6fnSopMLmSr0cwQi+lJBb1X5Mpp
         p6wT1hkdIEa0+exUkSPXxLjgkKvD+hd8WluULNqgKePndgAWHmTKf7iDFZYD36ufRit9
         siKaEPTgQ3cE3dMAb5vwIRWx3qwXgk1RY4+U/6E12MfFougA2MZbr6UEz0Jk1InvabGt
         eIClvJmAXLP/oo1aleKzAwxAOe4rW9mU4oFzbEPKRiQ0ASkOvloLzUVic4DzlcGnKP56
         XLy+xhfBd5gso/h3rQMp7rke0yekMTwICgY6lxdcL2mpRlyOLcd9IGnyHtdeabthCPuh
         X0DA==
X-Gm-Message-State: AOAM532/0sEUlx803k5qz46WWHbX1dCT23m7oCTn6Dm0+Nmp6Joh1uZ0
        dmZqga2usflrVE1hQyrgLxY=
X-Google-Smtp-Source: ABdhPJwFUNXtcXfFkMdgXhgbQ4Y6ITGtpNl3UJPY5b45UdtubRh2rHcY2853wgdyMPNi4Jb/I1ZtvQ==
X-Received: by 2002:a2e:9019:0:b0:22e:1b3:190d with SMTP id h25-20020a2e9019000000b0022e01b3190dmr12173130ljg.160.1645371871767;
        Sun, 20 Feb 2022 07:44:31 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.64])
        by smtp.gmail.com with ESMTPSA id j3sm854767lfr.132.2022.02.20.07.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 07:44:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------j63aUzZwTrBB7psgfIP2n1nX"
Message-ID: <cd08c05f-f648-071f-d8f5-0a022cd35b7b@gmail.com>
Date:   Sun, 20 Feb 2022 18:44:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in thrustmaster_probe
Content-Language: en-US
To:     syzbot <syzbot+35eebd505e97d315d01c@syzkaller.appspotmail.com>,
        alexandre.torgue@foss.st.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, syzkaller-bugs@googlegroups.com
References: <000000000000d181a205d874c066@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000d181a205d874c066@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------j63aUzZwTrBB7psgfIP2n1nX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/22 18:27, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c5d9ae265b10 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14ccc65c700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
> dashboard link: https://syzkaller.appspot.com/bug?extid=35eebd505e97d315d01c
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175ecbf2700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109973f2700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+35eebd505e97d315d01c@syzkaller.appspotmail.com
> 
> usb 1-1: config 0 interface 0 altsetting 0 endpoint 0x81 has invalid wMaxPacketSize 0
> usb 1-1: New USB device found, idVendor=044f, idProduct=b65d, bcdDevice= 0.40
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 1-1: config 0 descriptor??
> hid-thrustmaster 0003:044F:B65D.0001: unknown main item tag 0x0
> hid-thrustmaster 0003:044F:B65D.0001: hidraw0: USB HID v0.00 Device [HID 044f:b65d] on usb-dummy_hcd.0-1/input0
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in thrustmaster_interrupts drivers/hid/hid-thrustmaster.c:162 [inline]
> BUG: KASAN: slab-out-of-bounds in thrustmaster_probe+0x8d5/0xb50 drivers/hid/hid-thrustmaster.c:330
> Read of size 1 at addr ffff88807f1a59d2 by task kworker/1:1/35
> 

Looks like missing check for malicious device. Need to check number of 
endpoints before accessing endpoints array


#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master





With regards,
Pavel Skripkin
--------------j63aUzZwTrBB7psgfIP2n1nX
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC10aHJ1c3RtYXN0ZXIuYyBiL2RyaXZlcnMv
aGlkL2hpZC10aHJ1c3RtYXN0ZXIuYwppbmRleCAwM2I5MzVmZjAyZDUuLjI0NGMzYWE0ZDBj
MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9oaWQvaGlkLXRocnVzdG1hc3Rlci5jCisrKyBiL2Ry
aXZlcnMvaGlkL2hpZC10aHJ1c3RtYXN0ZXIuYwpAQCAtMTU4LDYgKzE1OCwxMSBAQCBzdGF0
aWMgdm9pZCB0aHJ1c3RtYXN0ZXJfaW50ZXJydXB0cyhzdHJ1Y3QgaGlkX2RldmljZSAqaGRl
dikKIAkJcmV0dXJuOwogCX0KIAorCWlmICh1c2JpZi0+Y3VyX2FsdHNldHRpbmctPmRlc2Mu
Yk51bUVuZHBvaW50cyA8IDIpIHsKKwkJaGlkX2VycihoZGV2LCAiV3JvbmcgbnVtYmVyIG9m
IGVuZHBvaW50cz9cbiIpOworCQlyZXR1cm47CisJfQorCiAJZXAgPSAmdXNiaWYtPmN1cl9h
bHRzZXR0aW5nLT5lbmRwb2ludFsxXTsKIAliX2VwID0gZXAtPmRlc2MuYkVuZHBvaW50QWRk
cmVzczsKIAo=

--------------j63aUzZwTrBB7psgfIP2n1nX--
