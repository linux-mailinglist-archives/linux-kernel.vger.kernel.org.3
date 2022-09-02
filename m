Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3694D5AA420
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiIBAQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiIBAQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924125A2ED
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662077789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJXkmWS8fs1OJFQDlt9uEZ42yIaPYlfbQFXo4qcCOho=;
        b=XghEN3ex6dj8EhqOOlzXMzGip9zWYpIxvF2vmoplvuk31itrVWKZRXa9nA0Jt3URJ+XqOi
        FsuTcrz3Y3vQapBIZkPhwyK+8hEc/T/8hDaxp28Fdq7xxwLsEYVoMAvFdzBGGPR02vbbHn
        bFU3azEbGIT7DsW0TeyDLOdC5QgOIf4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-scxsVwOYOoejiajHlzOj2A-1; Thu, 01 Sep 2022 20:16:28 -0400
X-MC-Unique: scxsVwOYOoejiajHlzOj2A-1
Received: by mail-qv1-f69.google.com with SMTP id q14-20020a0cf5ce000000b00498ee127c81so269599qvm.23
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 17:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BJXkmWS8fs1OJFQDlt9uEZ42yIaPYlfbQFXo4qcCOho=;
        b=WtTDusbtilMod9tvFOXmFpa76eUfWS64258/PnYQL67qx4ltJriE7BEVGmTczzieKI
         IxsASod1SmKDcBR/9Txu3X5C90bHTho4fOeNgR+00HcGG5vNDdf5SirbuAE43+IhlO8Q
         SRbFFB7RuE8CV/NFelE5LEixL5y0WofkhLZS4NV2edK/Ct0DaCk7hRQrSfq2myFKKuqw
         0tLa2u3+iPO130Fe6ETq/ZV1ngKAbA51Q08y1WJqp0dnOvarr7X8Fy597eiv8uutRK9a
         peJSa46EyZtoBlYFt12Jm7RHktDNmji0FsC/86T1clRDNYOwFmwLdS+kPpjIDgAFgR3J
         oEbA==
X-Gm-Message-State: ACgBeo1EV5lsIZgX5EjZwjUPE1WI/PXbC67opLkcI2wqgPy/3oL22D+F
        YeFLvYucTYkkFufnxg0IiGdsJxi0yx4PQRY+jhjPjBWFOPGE4TWRlra580g67gg7KCYLSlxnELs
        ay2Lv9Mu67z1OpLHjFo9JEMc=
X-Received: by 2002:ac8:5a09:0:b0:344:69c7:d405 with SMTP id n9-20020ac85a09000000b0034469c7d405mr26543394qta.158.1662077787572;
        Thu, 01 Sep 2022 17:16:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6xfpUx4j6Jfald4N7jmwOFuH/AS+dP1NbvYV//P7CHrd0ECl3dDoJBwQdLGwkp4TF0/VDNjg==
X-Received: by 2002:ac8:5a09:0:b0:344:69c7:d405 with SMTP id n9-20020ac85a09000000b0034469c7d405mr26543381qta.158.1662077787384;
        Thu, 01 Sep 2022 17:16:27 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a404700b006b5cc25535fsm297002qko.99.2022.09.01.17.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:16:26 -0700 (PDT)
Date:   Thu, 1 Sep 2022 20:16:25 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de, bvanassche@acm.org,
        pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        gost.dev@samsung.com, jaegeuk@kernel.org, matias.bjorling@wdc.com,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v12 08/13] dm-zoned: ensure only power of 2 zone sizes
 are allowed
Message-ID: <YxFLWcY/xSqyqORO@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121909eucas1p113c0c29f7e28d0ee3e1161f7da243baf@eucas1p1.samsung.com>
 <20220823121859.163903-9-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823121859.163903-9-p.raghav@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23 2022 at  8:18P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> dm-zoned relies on the assumption that the zone size is a
> power-of-2(po2) and the zone capacity is same as the zone size.
> 
> Ensure only po2 devices can be used as dm-zoned target until a native
> support for zoned devices with non-po2 zone size is added.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

