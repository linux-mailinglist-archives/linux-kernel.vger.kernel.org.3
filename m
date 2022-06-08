Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B155428C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiFHH7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiFHH6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:58:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536E720EE86;
        Wed,  8 Jun 2022 00:33:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bg6so19855142ejb.0;
        Wed, 08 Jun 2022 00:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=al6uMPCdvbAtX8ruwnHnA0G0kBr4QU1mqamtCwMfyXE=;
        b=CBbjmk7g/q2NL183FleRyhAqNLcVzzXUrP63fHkRbjWRDXqsZjIbEpjBVLMlj8CyUI
         CIkidgeuM4bTliykltzAo1itGxpx9XrTDaxuXPamB0kRlbkWFiq0jd/1sOyPKI2AIMya
         41HSq5ZHhp5rTyxKz29Etkuh0QOlOHQ1K2RiEqrQaC0Cf1Vi3WR4rBToego7/oSMMclC
         9azSB4x/gg/GYJ1tkPLfcYZjB//+B19fYV1X2lurg37pck5vI1G7AjxfWmUXU15Ckb5B
         aAw+hyLBL3CAxGyv1dK+8gU+WbtQbtfj9LSL1COTVEaMKcUEsT6/j9b31i0vLg8A4pjy
         LE1g==
X-Gm-Message-State: AOAM530o2iFFge9alCnMNjBWgDHxxUPvLjC8PHxgJ5gGMxsEeFqwpd4r
        Sc9g5uspIA1Tj/oBDvjqd4s=
X-Google-Smtp-Source: ABdhPJzC6YuOKMJYbKjEW9a9NEOzHrQG7ncU4tYuOwnI1N5sWINWZ6k/N/xj7lepCuseLljAb9Wsxw==
X-Received: by 2002:a17:907:7294:b0:6ff:200e:8d62 with SMTP id dt20-20020a170907729400b006ff200e8d62mr30157738ejc.719.1654673455298;
        Wed, 08 Jun 2022 00:30:55 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id v3-20020a056402348300b0042dccb44e88sm715283edc.23.2022.06.08.00.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 00:30:54 -0700 (PDT)
Message-ID: <e9fdf394-9dd2-b1d3-29c9-66eb3353c0ec@kernel.org>
Date:   Wed, 8 Jun 2022 09:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 10/36] tty/vt: consolemap: introduce UNI_*() macros
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220607104946.18710-1-jslaby@suse.cz>
 <20220607104946.18710-10-jslaby@suse.cz>
 <2e2623a0-4b9f-f15d-78e0-d6e335bdcdff@linux.intel.com>
 <54049291-db20-a536-0615-cc3b56ceb3a3@kernel.org>
In-Reply-To: <54049291-db20-a536-0615-cc3b56ceb3a3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 06. 22, 8:59, Jiri Slaby wrote:
> On 07. 06. 22, 15:47, Ilpo Järvinen wrote:
>> On Tue, 7 Jun 2022, Jiri Slaby wrote:
>>
>>> The code currently does shift, OR, and AND logic directly in the code.
>>> It is not much obvious what happens there. Therefore define four macros
>>> for that purpose and use them in the code. We use GENMASK() so that it
>>> is clear which bits serve what purpose:
>>> - UNI_GLYPH: bits  0.. 5
>>> - UNI_ROW:   bits  6..10
>>> - UNI_DIR:   bits 11..31
>>>
>>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>>> ---
>>>   drivers/tty/vt/consolemap.c | 21 +++++++++++++--------
>>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
>>> index 016c1a0b4290..e5fd225e87bd 100644
>>> --- a/drivers/tty/vt/consolemap.c
>>> +++ b/drivers/tty/vt/consolemap.c
>>> @@ -190,6 +190,11 @@ static int inv_translate[MAX_NR_CONSOLES];
>>>   #define UNI_DIR_ROWS    32U
>>>   #define UNI_ROW_GLYPHS    64U
>>> +#define UNI_DIR(uni)        ( (uni)                   >> 11)
>>> +#define UNI_ROW(uni)        (((uni) & GENMASK(10, 6)) >>  6)
>>
>> This is opencoding what FIELD_GET() does. Maybe just define these as
>> masks and use FIELD_GET in the code below.
> 
> Ah, great -- I was thinking there should be something for that purpose 
> already, but didn't find this. But let's define these UNI_* macros using 
> appropriate FIELD_GET(). (And not using FIELD_GET() in the code.)
> 
>>> +#define UNI_GLYPH(uni)        ( (uni) & GENMASK( 5, 0))
> thanks,

JFYI, I ended up with this diff to the original approach:
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -23,6 +23,8 @@
   * stack overflow.
   */

+#include <linux/bitfield.h>
+#include <linux/bits.h>
  #include <linux/module.h>
  #include <linux/kd.h>
  #include <linux/errno.h>
@@ -190,10 +192,17 @@ static int inv_translate[MAX_NR_CONSOLES];
  #define UNI_DIR_ROWS   32U
  #define UNI_ROW_GLYPHS 64U

-#define UNI_DIR(uni)           ( (uni)                   >> 11)
-#define UNI_ROW(uni)           (((uni) & GENMASK(10, 6)) >>  6)
-#define UNI_GLYPH(uni)         ( (uni) & GENMASK( 5, 0))
-#define UNI(dir, row, glyph)   (((dir) << 11) | ((row) << 6) | (glyph))
+#define UNI_DIR_BITS(max)      GENMASK((max), 11)
+#define UNI_ROW_BITS           GENMASK(10,  6)
+#define UNI_GLYPH_BITS         GENMASK( 5,  0)
+
+#define UNI_DIR(uni)   FIELD_GET(UNI_DIR_BITS(sizeof(uni) * 8 - 1), (uni))
+#define UNI_ROW(uni)   FIELD_GET(UNI_ROW_BITS, (uni))
+#define UNI_GLYPH(uni) FIELD_GET(UNI_GLYPH_BITS, (uni))
+
+#define UNI(dir, row, glyph)   (FIELD_PREP(UNI_DIR_BITS(31), (dir)) | \
+                                FIELD_PREP(UNI_ROW_BITS, (row)) | \
+                                FIELD_PREP(UNI_GLYPH_BITS, (glyph)))

  /**
   * struct uni_pagedict -- unicode directory

=======================================================

More text, but easier to follow, I think. except the UNI_DIR_BITS() has 
to have a parameter, otherwise compilation raises a too-big value 
warning with use of UNI_DIR() in con_insert_unipair() where uni is only 
of ushort type. Alternatively, we can cast uni to u32, but that produces 
worse assembly (extensions to u32 here and there).

thanks,
-- 
js
suse labs
