Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F334D50EECB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242504AbiDZCe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242464AbiDZCeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:34:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496CA12635C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:31:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id b12so14138977plg.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=HYfqHIhGpF7h06NPUNks3StayBg+7Ba4Glt42nafQ6c=;
        b=m/aFJlQouYbRDOGTpcr3fc2wpt542FoVPjIolTelK+zIKMya1dIjHiXtjf52WnQ4f3
         0alGlQdiic+RtQDtYANB+5VeVbW7h2El8i2q5Uon6BTkUMKXrE2g1819Nvu9dgUbjjJL
         QSJHKP/taBEEU2qG4Vpm/XGmdeHBzjdEXYpGHsLAoNAB9tQy69ya0RPYpQyqFSnMOR3S
         vdf85SOcOKjaXgH5J5fTPJzo/HdxPqfURBJZTTca2z6FLZ4OyyP4Mrf6mcD1BOFj2u2Z
         +/sOLqxErsIZE/eqRCNroZ3+exVDZMyewR55mgoU4DQ91buUa4C36J4WV5SdldzL8TX/
         z1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=HYfqHIhGpF7h06NPUNks3StayBg+7Ba4Glt42nafQ6c=;
        b=V2tCTIWFrEhd60LNAWkZYb2fc93joE8jZ2wnzlCiKpzykrn7qYOGBuIpEfNt7bX8CK
         JSggXpZr5HTWK0BBwwMFhUsHS0enberAuRZoePxIW4X+e40XP4bTqUdDpo2cI9T0lc2G
         FTqWRgHBVIZyeuDRmM+tpcQhXR+Wo9hO60bgmh12UZm5abrXzcxyMUVphxTjV2WwvfTk
         dHCdnr+oRKZ89h/e1TGY4EQFq8LUqAgKpcf7oZ9PvlBmLEVUi2/Klef+zvk6EMKwUZwr
         Sy0S7fiAbtEiG6qJU4tvE1pDVk+rwp61v3c3WS1956IONTL90qS1MwfwAJaf38oRHb50
         753Q==
X-Gm-Message-State: AOAM531rovJgBMhWdCDeV8+6/4YNqIp43R6wZaCk+0qXBqFmBbN4lkS6
        xmLN53h1j1ChtaMv3SyGbjsfDw==
X-Google-Smtp-Source: ABdhPJxvTvc7QIqFoQYPK5fpEOgE2RM5Gz48WDV6YRIgcHkrFcdt/JQ9fCENJM/OR21vt/OkpJM3Ig==
X-Received: by 2002:a17:902:bd0c:b0:158:f864:4d9d with SMTP id p12-20020a170902bd0c00b00158f8644d9dmr20763991pls.13.1650940299757;
        Mon, 25 Apr 2022 19:31:39 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090adc8100b001d9424e49c1sm676371pjv.44.2022.04.25.19.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 19:31:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     chaitanya.kulkarni@wdc.com, shinichiro.kawasaki@wdc.com,
        yukuai3@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
In-Reply-To: <20220426022133.3999006-1-yukuai3@huawei.com>
References: <20220426022133.3999006-1-yukuai3@huawei.com>
Subject: Re: [PATCH] null-blk: save memory footprint for struct nullb_cmd
Message-Id: <165094029875.72509.3390339725421776639.b4-ty@kernel.dk>
Date:   Mon, 25 Apr 2022 20:31:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 10:21:33 +0800, Yu Kuai wrote:
> Total 16 bytes can be saved in two ways:
> 
> 1) The field 'bio' will only be used in bio based mode, and the field
>    'rq' will only be used in mq mode. Since they won't be used in the
>    same time, declare a union for them.
> 2) The field 'bool fake_timeout' can be placed in the hole after the
>    field 'error'.
> 
> [...]

Applied, thanks!

[1/1] null-blk: save memory footprint for struct nullb_cmd
      commit: 8ba816b23abd2a9a05705f3d00b8653f8be73015

Best regards,
-- 
Jens Axboe


