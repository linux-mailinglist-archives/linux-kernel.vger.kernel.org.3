Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA391506D86
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244134AbiDSNfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243962AbiDSNfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5AD72252A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650375187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8pwv+ZJJLl/50u6bBL/op2XVemL1XAIahtW2NWtn0M=;
        b=W/Car/mpIYkNk7Zi0VXMgW0cHbj5q9npRJ+1A8EjWQqtxExh/3hWdZW0gUp20hFKsUrl0z
        boJMV4saDX8C4WuWBRbNXewQ6kJjlBnmZNKtFGFQv6+MTh2bUpjo9SnYm8ye45UlcFLOUX
        sPYeRgolBIo2gjuTpjN1K8c1eit65bw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-bT9QotdvN2Cr_MvpubGgyA-1; Tue, 19 Apr 2022 09:33:05 -0400
X-MC-Unique: bT9QotdvN2Cr_MvpubGgyA-1
Received: by mail-wr1-f71.google.com with SMTP id q4-20020adfc504000000b002079c9cc1bfso1932866wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=A8pwv+ZJJLl/50u6bBL/op2XVemL1XAIahtW2NWtn0M=;
        b=X7AA7KZ3vxodFgb6WdJaXqtrSObtAr+mZq9jdLMoKdJO0yuocDeRKPkpaA/Hv7Kgpz
         eItJJ+QnA1ACV4OYLPrb0Vn4z5cnj+0e9np7b9bd2sVt55Ht/qOQ3a/5r6Z8C0pGZGsO
         6zQeFsUBUKfVg/B7n6jDhJwOXZHv43k+y76pw+QcH96EGbshYm9ag8oltI5zs0Zhux6w
         spWJr1nVKBmI/g4g/GisCEDeCl3RCPJDp4SqJ/em7EFUgcYKKV6UfZtp4zQYX3u9wz/j
         5ukBLGM9Srb1mNT37JG0j1Au1VOdVSYPM7mO90epDqV0vl60JXmsXYIsH1LyQddPFwij
         Mz/Q==
X-Gm-Message-State: AOAM533znPCEu0Wqs9hiupDW86Q0f/95NAftUcy0HWZqQAAXDxTCrHV+
        8tHJIBESbXP8BcCYa6wkzJXf5zTmmg/5jIsZhckgADgeEqvzcakaCYiMBU+TDpTBrnhs/GcEPPE
        UQd7eSI8Rb9/BAFNQY832eNY3
X-Received: by 2002:a5d:6c66:0:b0:20a:847e:10b9 with SMTP id r6-20020a5d6c66000000b0020a847e10b9mr12598304wrz.82.1650375184375;
        Tue, 19 Apr 2022 06:33:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyny5RmHcL2mbVm8I+PvJJLONO+23YRsNsEl9fAKl0NIr73J24wL35Tq33t2C+DgjfmxE8aVw==
X-Received: by 2002:a5d:6c66:0:b0:20a:847e:10b9 with SMTP id r6-20020a5d6c66000000b0020a847e10b9mr12598291wrz.82.1650375184144;
        Tue, 19 Apr 2022 06:33:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-237.dyn.eolo.it. [146.241.96.237])
        by smtp.gmail.com with ESMTPSA id v2-20020adf8b42000000b0020aa790a258sm1535002wra.8.2022.04.19.06.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 06:33:03 -0700 (PDT)
Message-ID: <c7d700d8ae15a709424dd337ce459c50406c0a6c.camel@redhat.com>
Subject: Re: [PATCH 2/2] Trigger proper interrupts in igc_xsk_wakeup
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jeff Evanson <jeff.evanson@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jeff.evanson@qsc.com
Date:   Tue, 19 Apr 2022 15:33:02 +0200
In-Reply-To: <20220415210546.11294-1-jeff.evanson@qsc.com>
References: <20220415210546.11294-1-jeff.evanson@qsc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-15 at 15:05 -0600, Jeff Evanson wrote:
> in igc_xsk_wakeup, trigger the proper interrupt based on whether flags
> contains XDP_WAKEUP_RX and/or XDP_WAKEUP_TX
> 
> Signed-off-by: Jeff Evanson <jeff.evanson@qsc.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 36 +++++++++++++++++------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index a36a18c84aeb..d706de95dc06 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6073,7 +6073,7 @@ static void igc_trigger_rxtxq_interrupt(struct igc_adapter *adapter,
>  int igc_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
>  {
>  	struct igc_adapter *adapter = netdev_priv(dev);
> -	struct igc_q_vector *q_vector;
> +	struct igc_q_vector *txq_vector = 0, *rxq_vector = 0;

Since a v2 is likely required - see even Vinicius's comments on patch
1/2 - please reorder the above to respect the reverse x-mas tree order
and fix the sparse warning introduced above (s/ = 0/ = NULL/)

Thanks!

Paolo

