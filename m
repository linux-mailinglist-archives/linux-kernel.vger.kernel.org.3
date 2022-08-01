Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C9B586342
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbiHAEKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHAEKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:10:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D04CE3B;
        Sun, 31 Jul 2022 21:09:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v18so9348567plo.8;
        Sun, 31 Jul 2022 21:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=etAZitabdudMb3urn48XAitu4tsd3smIyp9vxBgD1Fg=;
        b=ZWqNBsV9OOqzQQlSjJwnkTPi+ll0ygmSlUSkm/6cMDX2JvqvW2sBDjoDMzzKdPJkqp
         Wlj/5XVrDgvKe4x/MfR/cD3UrC5U7uOZMsC3x/Ocr8ZJg6K5hmxz+B/dFfjbxgmkFXFf
         cYMBG1vCg8omNWTx0o0TtAv9NfdsqznzDFsygsI9+2spYMZUIPdsLLSjX1NI/HA3720Y
         ZLadfKoS84CQapQp09HkMnrwfH1WUq24sRmpjv8iHchg8Bl4doowcsZuYU4pP+rk/rst
         Iw05w5jhFDRzFHajSWKDtt4qzQZ4fuAZCSci6etwtXXb8jQEibc46wZlpkgfw6hJ34CY
         Iqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=etAZitabdudMb3urn48XAitu4tsd3smIyp9vxBgD1Fg=;
        b=onSrQvfWEZWlaBmt+HqzZdtc0hk9dh/8qepwHS6xWOExr2H+YAXcWNW9SKAy6jP2DY
         E+wcDUiBy6sVTtf+4tfSo4DOhnk2neFMJk3j9HgI6ZOMc7lA9SOj1qYF9Vjf3TuGxY1R
         c+t699M1EcTotzFABxZZ02U9qemMnwaXastsLvxW4K/QeNZEDWUdrjXQ0ikYlfyq4MHN
         DrWHshsBX2mlZ8BPXBpVC4ed1bNovJoNTjfVzBwGjjtLlkh9j0nsEjtW5PMRpVBd17yU
         ba5YZxce+czROIK254QZlI9rHiaS1tzgrHiEk9PXTOeMD9c8cHlsTHdPiRnWQAq9czfz
         FmIg==
X-Gm-Message-State: ACgBeo0bTPRZrTLnm/Y1IksmSKvyfuWcKx+5MRYquR2vAOdXGkpaj23u
        m5eCmoAMYfWpSdjbsuMpgrtbPa4LnGl2/Q==
X-Google-Smtp-Source: AA6agR6CQKGnvxDAk8Pn+T9aDBqSK5AyP+Ty5vEYX7XS6n8s6iM3Iw5eM33gYOPktHVfYI8hR+PLRA==
X-Received: by 2002:a17:902:8c8a:b0:16e:ceb1:d90a with SMTP id t10-20020a1709028c8a00b0016eceb1d90amr8679912plo.170.1659326999161;
        Sun, 31 Jul 2022 21:09:59 -0700 (PDT)
Received: from [192.168.0.110] ([103.159.189.156])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b0016dbce87aecsm8425736plf.182.2022.07.31.21.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 21:09:58 -0700 (PDT)
Message-ID: <3d33d2c6-ad56-a442-2458-5892138a4d9d@gmail.com>
Date:   Mon, 1 Aug 2022 10:09:45 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in imageblit (2)
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>,
        syzbot <syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <000000000000bbdd0405d120c155@google.com>
 <20220729065139.6529-1-khalid.masum.92@gmail.com>
 <eb4a26aa-da30-ceee-7d27-c1e902dd4218@gmx.de>
 <7973ec94-75ad-c133-032e-b83beeb2d397@gmail.com>
 <f15c9525-f21f-0599-3d5e-d9cbedc683df@gmx.de>
From:   Khalid Masum <khalid.masum.92@gmail.com>
In-Reply-To: <f15c9525-f21f-0599-3d5e-d9cbedc683df@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/22 21:39, Helge Deller wrote:
> On 7/31/22 15:55, Khalid Masum wrote:
>> On 7/30/22 23:25, Helge Deller wrote:
>>> On 7/29/22 08:51, Khalid Masum wrote:
>>>> Here is a simplified reproducer for the issue:
>>>>
>>>> https://gist.githubusercontent.com/Labnann/923d6b9b3a19848fc129637b839b8a55/raw/a68271fcc724569735fe27f80817e561b3ff629a/reproducer.c
>>>
>>> The reproducer does this:
>>> ioctl(3, TIOCLINUX, TIOCL_SETSEL, selection: xs:3  ys:0  xe:0 ye:0 mode:0)  = 0
>>> -> sets the text selection area
>>> ioctl(4, KDFONTOP)  with op=0 (con_font_set), charcount=512  width=8  height=32, 0x20000000) = 0
>>> -> changes the font size.
>>>
>>> It does not crash with current Linus' head (v5.19-rc8).
>>> Kernel v5.16, which was used by this KASAN report, hasn't received backports
>>> since months, so I tried stable kernel v5.15.58 instead, and this
>>> kernel crashed with the reproducer.
>>>
>>> The reproducer brings up two issues with current code:
>>> 1. The reproducer uses ioctl(TIOCLINUX, TIOCL_SETSEL) and hands over (invalid)
>>> zero-values for ys and ye for the starting lines.
>>> This is wrong, since the API seems to expect a "1" as the very first line for the selection.
>>
>> Why do you think that API expects a 1?
> 
> because the code in drivers/tty/vt/selection.c indicates this:
> See:
> static int vc_selection(struct vc_data *vc, struct tiocl_selection *v, struct tty_struct *tty)
> {
>          int ps, pe;
> ...
>          v->xs = min_t(u16, v->xs - 1, vc->vc_cols - 1);
>          v->ys = min_t(u16, v->ys - 1, vc->vc_rows - 1);
>          v->xe = min_t(u16, v->xe - 1, vc->vc_cols - 1);
>          v->ye = min_t(u16, v->ye - 1, vc->vc_rows - 1);
> ...
>          ps = v->ys * vc->vc_size_row + (v->xs << 1);
>          pe = v->ye * vc->vc_size_row + (v->xe << 1);
> 
> The userspace-provided xs,ys,xe and ye values are decremented by one
> before ps and pe (the pointers into the text screen array) are calculated.
> So, for the xs...ye values in the range from 1..max-screen-lines/columns
> are expected.

Oh. I got it. It is pretty simple. Thanks again for explaining.

> 
> Helge

Khalid Masum
