Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430F3527E99
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241135AbiEPHa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240656AbiEPHaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:30:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556D8F2D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:30:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bg25so8131698wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=NPhY2bRivndPO9ypmcyDBMt4UFQv/RM1UMuCHVzxwwo=;
        b=Dp55FezJWQYvlBXps2+7sCaZUcdWQklUQKfUoJn1oHUMJtK1jBetICi9NYGPQ/gMAn
         zn2dkZUl7MnKjarvXEx65nuZV8I8kTUq4hBC6yy2/HEyiocWa60DnbvpX9cdZClwEMWj
         0PuUHm3UJV/J9GZWuq+lpDyrFwYJyqo6BE/EaR2w0h4y1qwJC8FUIO54/ue8kHx4Y9C+
         H/WPgIAB/G4A9CTpZoa91EMucJH54IenI+1M5wAlGAIgwkxF0ZWIo2nwsxqdwFZd3o/G
         UxizcWclR87hKlrN6UXiX3ejmu8N+LB9ZXl62v82ekHb1V1GS2LsWpuKMNv/QdVaatUe
         SIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NPhY2bRivndPO9ypmcyDBMt4UFQv/RM1UMuCHVzxwwo=;
        b=Dt41AG39JhLlCeWbQac86TqTs3DzGGHvNO9hJemnWo45UuJ3yGIJCbBBczmalMeCSl
         uHlpEhLvbQd49kzE28+BtenllX+siU3du273Gj6PTaVY0d/CAeRJoBK8hK8m/54LUzZP
         qLX5YIZIZo5uz0aw0/Uj45ofbLHoDdzG1w1Rl6LggWQHN1EzGCNwDpGFnc2prt9iUoKA
         TUjY5/ajnkG0T88WT+kBSirNBiPQBY6S4OZPsR2TNUyi+pF0ZJ8uHG4wp5vtgi8KXQnA
         aKDG/J1tlCRKGSaqu7eRYoHdXx3PACORjDLciz7u7Wu1Ina/K3Lewf+aJvqxVtXcEp3d
         oe9g==
X-Gm-Message-State: AOAM531OqBMiH6a3WP60++VQXttE/x4zn4aES8GtomrNEbfLKVoQx+Nh
        dIkNe6Q4apdZYfkg8fbbA69SNw==
X-Google-Smtp-Source: ABdhPJz6+ODhxpvzTQwFkv//+c83ewq2117c0KUzKdjqeGZoLLk+h26lrIkZ2M2yCFw4KQ19w6kbCw==
X-Received: by 2002:a05:600c:26d2:b0:393:fb8c:dc31 with SMTP id 18-20020a05600c26d200b00393fb8cdc31mr26114507wmv.129.1652686250915;
        Mon, 16 May 2022 00:30:50 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:6d30:f384:3f7:365e])
        by smtp.gmail.com with ESMTPSA id n19-20020adfc613000000b0020c5253d927sm8772239wrg.115.2022.05.16.00.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 00:30:50 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/2] Input: mt6779-keypad - implement row/column
 selection
In-Reply-To: <YoHfUYmq49V5Bygd@google.com>
References: <20220513151845.2802795-1-mkorpershoek@baylibre.com>
 <20220513151845.2802795-3-mkorpershoek@baylibre.com>
 <YoHfUYmq49V5Bygd@google.com>
Date:   Mon, 16 May 2022 09:30:49 +0200
Message-ID: <875ym6kk7q.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for your review,

On dim., mai 15, 2022 at 22:21, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Fri, May 13, 2022 at 05:18:45PM +0200, Mattijs Korpershoek wrote:
>> The MediaTek keypad has a total of 6 input rows and 6 input columns.
>> By default, rows/columns 0-2 are enabled.
>> 
>> This is controlled by the KP_SEL register:
>> - bits[9:4]   control row selection
>> - bits[15:10] control column selection
>> 
>> Each bit enables the corresponding row/column number (e.g KP_SEL[4]
>> enables ROW0)
>> 
>> Depending on how the keypad is wired, this may result in wrong readings
>> of the keypad state.
>> 
>> Program the KP_SEL register to limit the key detection to n_rows,
>> n_cols we retrieve from the device tree.
>> 
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>>  drivers/input/keyboard/mt6779-keypad.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
>> index 23360de20da5..653dfc619696 100644
>> --- a/drivers/input/keyboard/mt6779-keypad.c
>> +++ b/drivers/input/keyboard/mt6779-keypad.c
>> @@ -17,6 +17,11 @@
>>  #define MTK_KPD_DEBOUNCE	0x0018
>>  #define MTK_KPD_DEBOUNCE_MASK	GENMASK(13, 0)
>>  #define MTK_KPD_DEBOUNCE_MAX_MS	256
>> +#define MTK_KPD_SEL		0x0020
>> +#define MTK_KPD_SEL_COL	GENMASK(15, 10)
>> +#define MTK_KPD_SEL_ROW	GENMASK(9, 4)
>> +#define MTK_KPD_SEL_COLMASK(c)	(MTK_KPD_SEL_COL >> (6 - (c)))
>
> Would it be clearer to say
>
> #define MTK_KPD_SEL_COLMASK(c)	GENMASK((c) + 3, 4)
Per my understanding, GENMASK is mostly used for build-time constants
since it does compile-time checks with BUILD_BUG_ON_ZERO.

Since "c" is defined at run time (as it comes from keypad->n_cols, which
comes from the device tree), it felt more appropriate to not use GENMASK.

Looking again, i've found examples in sound/soc/codecs/cs35l41-lib.c
that use GENMASK with a run-time value.

Will send a v2 using GENMASK, thank you for the suggestion.

>
> ?
>
> Thanks.
>
> -- 
> Dmitry
