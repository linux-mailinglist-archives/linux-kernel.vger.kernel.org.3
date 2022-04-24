Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4553C50D434
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbiDXSkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiDXSkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 14:40:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B644B8208;
        Sun, 24 Apr 2022 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650825418;
        bh=UvKCQlUNlr/TgkPZBp5HsaKQTUs9+ABQ4bq8v6UpLJk=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=jLth/pxMiZW52h9I7PcfdP/dNi44H7ouZo65OtZSarI3G4Tqoz16Ekv29seqF4aZl
         iO9P+RbTdFnzpWVxuyHcBy9TfPTDQYkgkOLyR7FSshLlvaNXx2HrFPArJCBnn8S1A8
         qW4/BCJ/I6V4C5A1RnODyEpXWLO3VUkhPj+Bnx14=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.161.75]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYPi-1oOKNl3tFo-00fy0p; Sun, 24
 Apr 2022 20:36:58 +0200
Message-ID: <f27c08b1-609a-a7f1-016f-8b782fa031b3@gmx.de>
Date:   Sun, 24 Apr 2022 20:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v6 03/17] parisc: define get_cycles macro for
 arch-override
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-4-Jason@zx2c4.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220423212623.1957011-4-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:00sPblPzC3czktD0McP3wFyeDNkVLT2TyPsr1FyYeILj/g2oXJW
 bHKvKlZ0L1gQd1eA/U54aSk/GnlNnRixp723PdmA2dM+CxkfKo6+HJis+LFCWLRKqCj8ma9
 WdhcY9OQlmgKgdKwF/NbAEqFHkQ8eh5kG8ago4AiW8TiV8MhEvldaPoei9vI7yils8oKptx
 PLXButH3qko3tZzClTdBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/MIQnKEnfMY=:aCa/AeRTstRFKD6yMmNfHN
 Y1l+Ungrc3Fq1ChPcJrQmXfp0Db3SvCbPPe6SbKmjLDuOFxmH3QrndVAHRDu/8nRKo1OE0gWi
 8i//PXth0x8fFkK6tDIHwsnq7ySMM4o/tEJ5dLjUn1LlpmoZHr7+cghkXJwpx8u6/ub4E/zH+
 60LxYiH4pNzJ1o915i9OTp6n6AAGBACtIEkOToxMfegNlfqRi74E+yN0ul0vRcMqJoKJ5IfP2
 hT1I689FQGUwcLYCbbGVD/j9Gv0tovlug/kcJc6B9L5JQYydQiP9qjlI1I20UuukIAkN5ICTo
 W3M8wgojm8by9EMWM8IIqmVeXvczgrILNiMpF0W514daSKBfreRTEc2OwDYK2Jz6Oqc56DoAh
 gHxWA+q+zey1YzS8XAXLkyOxC1AkmNRhV5TfGGShNoS+XB32JgRiwfcysz17TNe+2gx7qzJFX
 6dN+xC9YhR6cq5lZ5QjG+KPRTxgtucGb1FyJgA+SLv/2wBxfvUIyFkDp49J9TRVb4WR5KJhvs
 e7HiCTo1Jb83ijtIyXyBra6diWdXl04/IajyzuUn6JxZXFPcnAFf0wNBvFHckk60izH/mAkX0
 o9TSUjRu6UytZtg/juxMeluV7L0ryT4EeCUv0iX3Ky2RL/IONQ58ZadOJFf1vr+mdJP8XV6OQ
 EFEBo3q0OeXNoD6DcNZCBgD2g4y80uZmst+YVOTxHJB1FUJ5GOfEFkTg4wUMpBNhDyIpWTRjI
 0kFjh1eZNWDSzCu4X5eWChZLrl8a01cHov9uv/NP7S/YUe779buVHWJo5yiUVjRuRr1dTrXYg
 WQtxoM6LBzHZwr71xLNKKDUnrJ9P+CBQPtFFMhVBYqileI1auehU5cRE4xi8rU/+EPrGV+7BC
 wHP2MEX2f0M9v7Nkpch+1/vj2o9QEUxfkXLg0WcY/ftzhsIz1riVO0dzPMl9f1oKCoUNp/uWS
 Gwl5fb4sQtIJEzJkyVi3sNi7/oFGfqxi8CDaHy+II5b0nHrYsF73XLHQkqnCxqQOjDXjH9Xy0
 fTBbKKaT2yR89Zl+uYt+uWueeQDLKc5fF61cjmslwYx3h69l6ifdrml1YqNHAq/kbZ1aqAWKU
 JnzZFNFQ/VZylM=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/22 23:26, Jason A. Donenfeld wrote:
> PA-RISC defines a get_cycles() function, but it forgot to do the usual
> `#define get_cycles get_cycles` dance, making it impossible for generic
> code to see if an arch-specific function was defined.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Helge Deller <deller@gmx.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Acked-by: Helge Deller <deller@gmx.de> # parisc

Thank you!
Helge

> ---
>  arch/parisc/include/asm/timex.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/parisc/include/asm/timex.h b/arch/parisc/include/asm/t=
imex.h
> index 06b510f8172e..b4622cb06a75 100644
> --- a/arch/parisc/include/asm/timex.h
> +++ b/arch/parisc/include/asm/timex.h
> @@ -13,9 +13,10 @@
>
>  typedef unsigned long cycles_t;
>
> -static inline cycles_t get_cycles (void)
> +static inline cycles_t get_cycles(void)
>  {
>  	return mfctl(16);
>  }
> +#define get_cycles get_cycles
>
>  #endif

