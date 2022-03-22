Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8154E4742
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiCVUNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiCVUNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:13:14 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3254C60DA3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:11:46 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b67so14868768qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v00bZ5/GrtJkHwEVsUd7zi7yA5VU4pS81+ixMGyiNzw=;
        b=t+zVhg/8DWIoJ9+TtqA9MfYhQixNsuvDLGpv2FtmuHR13aC4IiMRykbt24V7fLjGf0
         KIp2nF82eLjNJn28YsTWtPDfhcIaeQ4w21KrccvrBOa9CmL6MRroZq2Me3AE1FTNQVoA
         UjWD1Wt+diwfRBF/jNshIDtN0nzoIK3pD2E1+x64Qn1Ct1NyY2TOlZNC0nDppzi2+MLT
         +9j0GwAgchYoFywDRL4PUiopvWmZSd0jAPkFiglav9xAvzA6+mId1xcPZnVm8vfGicTp
         cuUpL4VSxX0aN/KYHdyZjA4pBjttMlcN6fP50/DO/FAPZyZDsf8PwH+7JF3AGii+1ZL9
         s5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v00bZ5/GrtJkHwEVsUd7zi7yA5VU4pS81+ixMGyiNzw=;
        b=c4cY2x9e3PSTkwSVw4ueEI93EjbhHD/P1QE2oCjaFKuhj/vBW8ZXzzOwqimec1eztH
         ibVD73n7mwKOHg+Zq08qZIN3JxSYJpJY0AVjhm/9wJeKl3ChVUXXU3wtePNq9Ckt7cwY
         Joxa7WRs/+hnTNuQzbNJs3ayr7BWJVmfHg7pn+qvwlt8/Va988brlm6jAJ1wJoE4DFIW
         7YYonZSmCigIk2Vfr6zRTfAMjg98pzxfj/P6yYXfPWXvkbC0pi7UQYtuKjAaONlU2Tl4
         82kxw5c3evlL/2pYDFuUrZ/+Kx0QAO4WXRIHCJfvB2NCF+UUs/Bsr9E/jLS0ayL4ourC
         t0jQ==
X-Gm-Message-State: AOAM530k4e/B4sA+zqV24UfUDeb73J6keM2SiX/4zLf0REMrGUuUCygz
        imQMEXGW36S/PG4ZWi3oKYuEafcjQYMwkw==
X-Google-Smtp-Source: ABdhPJw2EzkiZtzBMvlZNpbdB92S79Fvr6YfPQrZJ+/2xT2gVC35TkQhMhJqaM4L+dUFXDBlTAKjmg==
X-Received: by 2002:a05:620a:200f:b0:67b:3fb7:8784 with SMTP id c15-20020a05620a200f00b0067b3fb78784mr16519494qka.336.1647979905206;
        Tue, 22 Mar 2022 13:11:45 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a16-20020a05622a02d000b002e20e4bf4aesm7517324qtx.23.2022.03.22.13.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 13:11:44 -0700 (PDT)
Date:   Tue, 22 Mar 2022 16:11:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     axboe@kernel.dk, bvanassche@acm.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
Message-ID: <YjotekJZcSvwoZhp@localhost.localdomain>
References: <20211227091241.103-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227091241.103-1-xieyongji@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 05:12:41PM +0800, Xie Yongji wrote:
> The rescuer thread might take over the works queued on
> the workqueue when the worker thread creation timed out.
> If this happens, we have no chance to create multiple
> recv threads which causes I/O hung on this nbd device.
> 
> To fix it, we can not simply remove the WQ_MEM_RECLAIM
> flag since the recv work is in the memory reclaim path.
> So this patch tries to create kthreads directly to
> handle the recv work instead of using workqueue.
> 

I still don't understand why we can't drop WQ_MEM_RECLAIM.  IIRC your argument
is that we need it because a reconnect could happen under memory pressure and we
need to be able to queue work for that.  However your code makes it so we're
just doing a kthread_create(), which isn't coming out of some emergency pool, so
it's just as likely to fail as a !WQ_MEM_RECLAIM workqueue.  Thanks,

Josef
