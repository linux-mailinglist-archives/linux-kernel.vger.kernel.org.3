Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C375AA427
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiIBARh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiIBARe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF4E73934
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662077852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1VQaTuOirjpYt85+XINqeDWNmKGLZ6/kyCDRTLfcVcM=;
        b=d+JfhFC+L4OOkN5yOGaHQGmF+sruV0cOneiuAoz5z+3m8v4EOjlD2K37IGLxgKU+iIeI1J
        zdaT1c7l2CtXCX+gLv2Fq73DVM9Jy3Z8GqQvKAMtZgPk765TV/4YatByHhW5yrR1ox/zVI
        RVMHAaB1gBV1N8dhdSVcsJZwnEdh7E8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-467-O3gsMkx1M6KMhgNEZxCrjQ-1; Thu, 01 Sep 2022 20:17:31 -0400
X-MC-Unique: O3gsMkx1M6KMhgNEZxCrjQ-1
Received: by mail-qv1-f70.google.com with SMTP id q14-20020a0cf5ce000000b00498ee127c81so270991qvm.23
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 17:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1VQaTuOirjpYt85+XINqeDWNmKGLZ6/kyCDRTLfcVcM=;
        b=VxC2/hv5Yh5PP8stULYyF38Qi4G0UzQcYvkg9JwnFnX54DNw78UeA9HHl669K/Ldf0
         wgfE7m4zQ6ni3oaQ6P30GRdKSPxx3SHE4tDkqEWb4bEON8TJmC9MoJITC94zkmbptOOm
         DrJn8aAp+MU9aL1OIkgy+8t7BRvs5mTdTW5zcB6YXasNfBDxABV9BAE7fulJ8z0ur1Ol
         2uOINAGB0ZqLTDecuO4QaNto4WCyIeTD/AbM+IYhDjuQmaMyKapFTKzfxyDSAUywx3U3
         a0UuZOhKCsPAYHshdan96KVMT/ruAJ49dSvBwO9jhLbhYje9UerVWEb+W5Ip0Gv2vv5X
         fe9A==
X-Gm-Message-State: ACgBeo3kxYEb5Ky6PNIvtd61zaV8fSNjn4UG3+ICnU4WXlD/V5RtKGpy
        W802cnYItX+iW+4f4ypSSCuRq1IOL5TtNkHltPv8BZibAT4yffIawLLcT54NnoAKtb49RKI4bHP
        03BM2qHQ4GUJd6LuV4AboFno=
X-Received: by 2002:a05:620a:170c:b0:6bb:208c:d276 with SMTP id az12-20020a05620a170c00b006bb208cd276mr21623962qkb.539.1662077850965;
        Thu, 01 Sep 2022 17:17:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5l1Y1wPC9cb0WfGk58FA5BvETyt3RQ0Hl5DfpLwLcYUCBnnMhNzZcJHR6wWE4FxqLZfiIC3A==
X-Received: by 2002:a05:620a:170c:b0:6bb:208c:d276 with SMTP id az12-20020a05620a170c00b006bb208cd276mr21623953qkb.539.1662077850790;
        Thu, 01 Sep 2022 17:17:30 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a290700b006b9593e2f68sm345562qkp.4.2022.09.01.17.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:17:30 -0700 (PDT)
Date:   Thu, 1 Sep 2022 20:17:29 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de, bvanassche@acm.org,
        pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        gost.dev@samsung.com, jaegeuk@kernel.org, matias.bjorling@wdc.com
Subject: Re: [PATCH v12 10/13] dm-table: allow zoned devices with non
 power-of-2 zone sizes
Message-ID: <YxFLmZ1KUwQ9LLDK@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121912eucas1p18223e1b04b65a8a10f6c50187e7474ea@eucas1p1.samsung.com>
 <20220823121859.163903-11-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823121859.163903-11-p.raghav@samsung.com>
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

> Allow dm to support zoned devices with non power-of-2(po2) zone sizes as
> the block layer now supports it.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

