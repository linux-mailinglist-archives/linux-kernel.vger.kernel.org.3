Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17452567491
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiGEQkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiGEQkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:40:11 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8944A1A04B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:40:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fi2so22604164ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+rlbyTOoNwQ/Ko9kU7HMBJWDAO4G26gh8EPsTC8+Ac=;
        b=CvJYEDjw33xcq9ffWI0Sh15l7ERobmRboSVWdG6w9CZXTAeudaN/kxmUbccG1863JG
         id2ETpVcfm3xuTTJoM7sw5Lr+vrEbFzbq4SAkfTxjME3FBLk4HsQDDvfjqNGShuqJtY2
         TRqdin+RuMoqbjxeMII8hxm3j+AdQWvNZczxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+rlbyTOoNwQ/Ko9kU7HMBJWDAO4G26gh8EPsTC8+Ac=;
        b=hoU7E7NOezG0UTMmg+l31DQSNACbRfcQdKVU6ia4tdoHfXygXUM8NJTLiZh/TXtSIe
         Wp0XM6Sv4Ngf4W6Y5eLGBqyX4SA8Aonl081DrVrt+ABeBmqZUPpe138MaDLGFXnnbzct
         +mQm7Pcgx2eoauJosRNIzPify81SUTHdGa56INnJYI3Ou/RATltrhk9AnR2OVMMj47zc
         Tpa64Kjaj+FQNrkxN3Qc/ahiR9AhJqE1Vk+yMlgB+qgJ6z551RwJz1Vk6fY9DfQeTfJ4
         cNi+eNXusO1uDJdwbTlHwSkZmi5DRABTlNLHlktfrTKhow8CGbL+aguFeAZre+UZG5oZ
         HF4A==
X-Gm-Message-State: AJIora9Oq+rEVRwQl95NBwvMkBv5pR9dGAMtFoGIXvjcdpPyVTuOFnss
        uwLSA38eW+eo36/40p5bfoJk/wBcjuoMtqrSRr4=
X-Google-Smtp-Source: AGRyM1sTmBIpE9MlH4Jjzag+HapQ1kvnxiffJ+VjwYgJQDbdLLAj6FgRP2cMZXsf6ztRAqm6SIw3TQ==
X-Received: by 2002:a17:907:97d3:b0:726:a5db:3a3a with SMTP id js19-20020a17090797d300b00726a5db3a3amr35724411ejc.654.1657039208820;
        Tue, 05 Jul 2022 09:40:08 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id kw24-20020a170907771800b0072a3216c23asm8952455ejc.154.2022.07.05.09.40.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 09:40:08 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id l68so7372109wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 09:40:08 -0700 (PDT)
X-Received: by 2002:a05:600c:15d5:b0:3a1:7bf2:124a with SMTP id
 v21-20020a05600c15d500b003a17bf2124amr32099371wmf.38.1657039207726; Tue, 05
 Jul 2022 09:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <272584304.305738.1657029005216@office.mailbox.org>
In-Reply-To: <272584304.305738.1657029005216@office.mailbox.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Jul 2022 09:39:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivGGgs9K_TfQYTW4RzH_C-JVfLZKNA5+hKQU0eNFBeiw@mail.gmail.com>
Message-ID: <CAHk-=wivGGgs9K_TfQYTW4RzH_C-JVfLZKNA5+hKQU0eNFBeiw@mail.gmail.com>
Subject: Re: [Regression?] Linux 5.19-rc5 gets stuck on boot, not rc4
To:     Tor Vic <torvic9@mailbox.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 6:50 AM <torvic9@mailbox.org> wrote:
>
> Linux 5.19-rc5 does not boot on my Kaby Lake Thinkpad.
> rc3 and rc4 were still fine, so I guess something between rc4 and rc5
> introduced a regression.

Sounds that way.

> Unfortunately, there are no errors or warning messages.
> It gets stuck quite early on boot, about the time USB is initialized,
> so less than 1 second into post-bootloader boot.
> It then just sits there doing nothing - SysRq still works though.

There aren't all that many changes in rc5, and your hardware looks
*very* standard (all intel chipset, and a Samsung SM961 SSD).

And with the lack of details, we'll either need a bisect:

> I don't have time for a bisect, but I thought I'll let you know about
> this issue, and maybe someone already has an idea.

or we'll need more reports..

> Some system information below. Root filesystem is f2fs.

Ok, f2fs is certainly unusual, but there are no f2fs changes in rc5.

There's some PM changes for i915 ("drm/i915/dgfx: Disable d3cold at
gfx root port") and a couple of thinkpad-acpi platform driver updates,
so I'm adding a few random people to the cc in case somebody goes
"ahh..."

But otherwise I think we'll just need more reports or info to even
start guessing.

              Linus
