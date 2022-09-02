Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E225AA45D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbiIBA3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIBA3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EFD96748
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662078542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JoL26AsmguCoQC8iT7uL94/0V02t17IP8zjffwCfRFk=;
        b=FWTONVXgdrjiSf6GSUsFwQ4pKZpFXYRUzAiFAi8rTa7kGtlfF3LSj2YeryzSwsEJgXyqwf
        swd4WsmnXxemCmI30alXn9SAPd4vq8RV6OB3dMsCyK2TslBhyk/aa0m3lo6eU4yBFIKUv4
        o7OEi4bDxybZYp7zUDLfDIdzAWPsmFU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-237-V5_AaOTDMSSIBhb9jOVxjw-1; Thu, 01 Sep 2022 20:29:01 -0400
X-MC-Unique: V5_AaOTDMSSIBhb9jOVxjw-1
Received: by mail-qt1-f200.google.com with SMTP id cj19-20020a05622a259300b003446920ea91so425660qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 17:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JoL26AsmguCoQC8iT7uL94/0V02t17IP8zjffwCfRFk=;
        b=4L1Q8tqdQJTkrXcLjlSUOZosmiMcaxJsvfvjPJt7JYxYxCzcsLCG6I30i/4xL/NTxD
         VEQmYku3vtpHMgagJPcSRwlCPNAUP6aCu48qcGv46Mg7b+RmfR1JAYRGgCtMgRkShMFc
         tjsRsIwSwkqpqXOdFwnBUkdKUpUt4LPJNqYO1fsOAvloauh7/xHdPt3B3H95L0YYhSUZ
         cZg5M4BO4/04GuRqYTu7ehhIwbQBFiy3KzBfSapKAwc300ZMYEEogP1VKnxCKRDBFF89
         5mE4Nsd0UlvuqPRPnju68xDhV0MK3KQtt182Ub3zEKf3zBJEOj4BsUDH+aR3jA61r9UH
         0Cpg==
X-Gm-Message-State: ACgBeo1hByuYT8XUZYvuK2IBdaHP8CI1IXoynNWkQ9Q3aaYfaXn1sQCt
        b+T2CDMmVNBuKlXF/wBaBbqPL3K2741GwF5SWV0ovEF33iapdhP7VnPxyWn7a1rdkev5HtqUC1k
        8k1NgtqQ99a8rRoZoFXPuU/k=
X-Received: by 2002:a05:622a:56:b0:344:50e3:3363 with SMTP id y22-20020a05622a005600b0034450e33363mr26078610qtw.217.1662078541492;
        Thu, 01 Sep 2022 17:29:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4ummQqIzdjpLP2wlMT3mmzaahpZ4roXiEIZrDjJAlvbH341hXfcfEvnw7FaTjjSfTvav+c8Q==
X-Received: by 2002:a05:622a:56:b0:344:50e3:3363 with SMTP id y22-20020a05622a005600b0034450e33363mr26078588qtw.217.1662078541288;
        Thu, 01 Sep 2022 17:29:01 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id 15-20020ac84e8f000000b0031f0b43629dsm180519qtp.23.2022.09.01.17.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:29:00 -0700 (PDT)
Date:   Thu, 1 Sep 2022 20:28:59 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de, pankydev8@gmail.com,
        Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com, hare@suse.de, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org, matias.bjorling@wdc.com,
        gost.dev@samsung.com, bvanassche@acm.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v12 12/13] dm: introduce DM_EMULATED_ZONES target type
Message-ID: <YxFOS8fq8AeE5mkf@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121914eucas1p2f4445066c23cdae4fca80f7b0268815b@eucas1p2.samsung.com>
 <20220823121859.163903-13-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823121859.163903-13-p.raghav@samsung.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23 2022 at  8:18P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> Introduce a new target type DM_EMULATED_ZONES for targets with
> a different number of sectors per zone (aka zone size) than the underlying
> device zone size.
> 
> This target type is introduced as the existing zoned targets assume
> that the target and the underlying device have the same zone size.
> The new target: dm-po2zone will use this new target
> type as it emulates the zone boundary that is different from the
> underlying zoned device.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

This patch's use of "target type" jargon isn't valid. 

Please say "target feature flag" and rename DM_EMULATED_ZONES to
DM_TARGET_EMULATED_ZONES in the subject and header.

But, with those fixed:

Signed-off-by: Mike Snitzer <snitzer@kernel.org>

(fyi, I'll review patch 13, the dm-po2zone target, tomorrow)

