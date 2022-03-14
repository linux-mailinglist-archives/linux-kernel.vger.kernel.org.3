Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BD14D8E11
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244976AbiCNUZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiCNUZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:25:09 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AA6338BA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:23:59 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id c23so19798832ioi.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=T1epUkuBEZR2LhEdTqhXHlnF09YRfThD+WUlWYZsbP0=;
        b=fWGutWI0+heOIc6s/q00lJpgol9Zvzto/tICQBOMfxpWn88QkI04LQNjbtcSoRtoNZ
         u6uWsaJjXbByOdfxzfe1qtbAIBQypO/oZyGNtMMSFPVTGcQNsKjgswRWumXleVk7Pncq
         zDDcwYAWM7ltxc+5zs6D+6nBX4VZsSLj4+ryaHBUi/GxNunfhRZ89zy01PhaWgklJF35
         92Hnji94/RVDOTuH/pSUDVr0ffZd1iFZZBy0L/aOM6ItNK4uBsvfrN9Tx/t5364NyonN
         eoTNaNSEy7FL+7FkWLjjRXC5D3tJKbdVOO5TPbUG8V0ux358zUKMSK/N3ayhXJ/WcEYJ
         gm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=T1epUkuBEZR2LhEdTqhXHlnF09YRfThD+WUlWYZsbP0=;
        b=xfUg0nLUc/P8EndZKBrRDGfDJpab5qHz9N1EhjcHK6P2tk38ZGbXhCa9tFX3GKC2s7
         H68mH14cqCWqhAq8f5WN1JYOcvwsxp0QIcNnzyFsJQu/NHYRDqPiHZeSNMJio7inc7X3
         5fCcOopv4LImRXFg1DKPv6o3KMSV7zErUfztJ6M9zG4CMVAEB21c7GKaDhyyVi4pSru7
         cLGoIXZjEw2XYA2PVFgv2z9gbi9L246SeSc8N2UROUWz2ypIN2Hc9G8xpPjTwrpU9+uB
         bxfbQKwQLIECGOKCobDwq8yrYQM+lVqZraLTxiDoV3TZ/rDgwzeKFh0BB+WMHBFP8rE9
         /VTw==
X-Gm-Message-State: AOAM533syxI8H2ho2Y2tdhqJcUMgzPuzUs20bPYQvSzrtiPknJEuicNV
        NHK3xkOzSa8ME2x31UpBADhxTQ==
X-Google-Smtp-Source: ABdhPJzFeprnrbWSaeXT0Xqz0t75bLQpl1HbWK/xqoNcZCH+IS0MjT6fe3aSlh6501m3gcpRMBYtHQ==
X-Received: by 2002:a02:1143:0:b0:308:eb2e:70ef with SMTP id 64-20020a021143000000b00308eb2e70efmr22039594jaf.248.1647289438486;
        Mon, 14 Mar 2022 13:23:58 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u15-20020a056e021a4f00b002c665afb993sm10033922ilv.11.2022.03.14.13.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 13:23:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai3@huawei.com>,
        kernel-team@fb.com,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Saravanan D <saravanand@fb.com>
In-Reply-To: <Yi7rdrzQEHjJLGKB@slm.duckdns.org>
References: <Yi7rdrzQEHjJLGKB@slm.duckdns.org>
Subject: Re: [PATCH block-5.17] fix rq-qos breakage from skipping rq_qos_done_bio()
Message-Id: <164728943786.144850.10059816217572335500.b4-ty@kernel.dk>
Date:   Mon, 14 Mar 2022 14:23:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2022 21:15:02 -1000, Tejun Heo wrote:
> a647a524a467 ("block: don't call rq_qos_ops->done_bio if the bio isn't
> tracked") made bio_endio() skip rq_qos_done_bio() if BIO_TRACKED is not set.
> While this fixed a potential oops, it also broke blk-iocost by skipping the
> done_bio callback for merged bios.
> 
> Before, whether a bio goes through rq_qos_throttle() or rq_qos_merge(),
> rq_qos_done_bio() would be called on the bio on completion with BIO_TRACKED
> distinguishing the former from the latter. rq_qos_done_bio() is not called
> for bios which wenth through rq_qos_merge(). This royally confuses
> blk-iocost as the merged bios never finish and are considered perpetually
> in-flight.
> 
> [...]

Applied, thanks!

[1/1] fix rq-qos breakage from skipping rq_qos_done_bio()
      (no commit info)

Best regards,
-- 
Jens Axboe


