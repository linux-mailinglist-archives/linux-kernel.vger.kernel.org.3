Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2413058D8D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242683AbiHIMlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242481AbiHIMlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:41:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E62CDEBC
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 05:41:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso17501597pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WNr40UtTfHF/fzuU8JQrB0PNXLcXxn2MQ4y4InLcGjc=;
        b=Xx6N+GU9iNYMwuT9/3lSx7jhoAsO+71/iNml5D96YGeHwBzYZ3j4ILPJ44KjqPbZe3
         YpGuTWn01YdM7o2ebvIdXXnxeasvcrqV5g6NPHfGpE3zxMzdH75dxLbuIGh1RZpw8R6K
         A33OK2AyhA1yEfQpBhmLaQvI4ASVr/4GmXQVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WNr40UtTfHF/fzuU8JQrB0PNXLcXxn2MQ4y4InLcGjc=;
        b=VZbdCBBbrw4gUkkmksiA0wsnTL24/gHpMliaeUQpNHHY0UfGhdyxLs2mekv+1CciJ6
         Zg/7jL7tlFreIQyDzdihtZ/fzbJWSJGSfKYhn7kE9C0nqoiS3+f8xtjqvt4lEnOtYtWq
         dfC5gcPKafm4jnRm7ZnKaKlfF+nNcPdM0SJix0eB/IE5+kV6MjF7W2OZ4U8usV+gzLBX
         VRrd9fRt4i8zm2l7MRofaudzVtBLXXlXdlgGe7bmj+we2b7Ub4z4rpb0+iDUm5Avwcgu
         RIzJm5/Azh5gEOPa6MzjXgGBdZfpCjb1+JlDf/TegHPz+vBGrv8j3PiHh7UyUnvJ7vI1
         ksvA==
X-Gm-Message-State: ACgBeo2ZvP7aimujMjQVPKAGj3pXSgdcIqACg4rMy5fzovD2y+IRj1Bv
        4aPYMy0+ZEvpovgNlkF9Blydkg==
X-Google-Smtp-Source: AA6agR4KP3+3TPwBOflqXePsVYMZv0/sRTeKgbWH6qJxglrD40OZS+CxcNTbdAS84lMcYYtGG4KzUw==
X-Received: by 2002:a17:90b:4f49:b0:1f5:c7c:b565 with SMTP id pj9-20020a17090b4f4900b001f50c7cb565mr35356292pjb.32.1660048887790;
        Tue, 09 Aug 2022 05:41:27 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8d43:c739:457a:5504])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b0016dbaf3ff2esm10719392plk.22.2022.08.09.05.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 05:41:27 -0700 (PDT)
Date:   Tue, 9 Aug 2022 21:41:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>,
        Minchan Kim <minchan@kernel.org>
Cc:     akpm@linux-foundation.org, ngupta@vflare.org,
        senozhatsky@chromium.org, linux-block@vger.kernel.org,
        axboe@chromium.org, kernel@sberdevices.ru,
        linux-kernel@vger.kernel.org, mnitenko@gmail.com,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [PATCH v5] zram: remove double compression logic
Message-ID: <YvJV8rU9bkqiy9iA@google.com>
References: <20220505094443.11728-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505094443.11728-1-avromanov@sberdevices.ru>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/05/05 12:44), Alexey Romanov wrote:
> @@ -1975,7 +1954,6 @@ static int zram_add(void)
>  	if (ZRAM_LOGICAL_BLOCK_SIZE == PAGE_SIZE)
>  		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
>  
> -	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, zram->disk->queue);

By the way, why did it remove QUEUE_FLAG_STABLE_WRITES bit?
