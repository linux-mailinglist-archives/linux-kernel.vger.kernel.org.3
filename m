Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1299052570A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358714AbiELVbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358720AbiELVbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:31:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7462714B;
        Thu, 12 May 2022 14:30:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n10so12714907ejk.5;
        Thu, 12 May 2022 14:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gK0S633BRVG9XKnxNIbh5zmaAdePdUb1YxCYCbMDKlQ=;
        b=evpOXJ7mR/GrzvT5sJ8qKsvt9Wu7jYdy1syBKVEJOflRkIHbrBWaB1Xc3YgKUnNcg9
         sStHMxncwlQnp0Z1kNGuBkA1nlu63Zvcp3jmNJn2xZHcptlYwq4dbmwVq37PhpoO5OjS
         +yr/XthlXaMsn7PKZNa2NcJ94ToJDQwOH0u9WWtfgQ0HRbgYDx1BRooMgHro0gbG+4lr
         z93vSGwDQqUiFJbs4vG7REmpFyAg3dUlbvdEJLaTVpf/TjkvlD8pVnl1AqMSIQ1hPLXr
         A++leY3ieJM31ccIbIOLOPD02Wbi5NLATFSo1lztfITSWremsI4bC1iKxuXy7nMbxUNU
         mWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gK0S633BRVG9XKnxNIbh5zmaAdePdUb1YxCYCbMDKlQ=;
        b=SCXdgRLLIcTtEwlOJkJngB4OgF0HGnU5By4f8mGQamhCMfZrEt2X6lVrcJrjqKhpBH
         wZsY2iI6TTu1OmRPaLj2BgEJB1qmE4JxE+1EGk/v/yiM7/yhIgAz1QXvi2GZd7+GlqJE
         a6WjlwHCqWvrn430BVim5u7ZkUHXFJJa/VDAngFmZED+wUGFygaE23s8W964tITSzG3y
         7OyoAoq9K4T8vH1J6Mlub0l7vy4MuPA/dmq48HjoRurm8fSku1qUEzbeLr1OTkrYJ2vL
         Hsb/tJoAUzl1RnC64rHWQUruyf6KLC2Wj7ZdV6k4y+T2fh2/Lqr9CGjLrUpZEgBWEI8G
         8HVA==
X-Gm-Message-State: AOAM532i+ukVLd77L/ur4+W47297nN92PZIEGZ4lBihcaZ3k8BVvr2EC
        /EfoS+bKjUgf6NqLassa3nSotbsWq9sn8rze
X-Google-Smtp-Source: ABdhPJzuxe1Cd5h5yKYd2ecanRmqpDYWx/bjaLfDTiaxQbNCdUd/8vXJZQMxVcqCLL0zTEEEcWA6BQ==
X-Received: by 2002:a17:907:6daa:b0:6f4:4822:549d with SMTP id sb42-20020a1709076daa00b006f44822549dmr1688240ejc.322.1652391055346;
        Thu, 12 May 2022 14:30:55 -0700 (PDT)
Received: from penguin ([80.149.170.9])
        by smtp.gmail.com with ESMTPSA id eo12-20020a056402530c00b0042617ba63c3sm93272edb.77.2022.05.12.14.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 14:30:54 -0700 (PDT)
Date:   Thu, 12 May 2022 23:30:37 +0200
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: evdev: fixed case statements
Message-ID: <Yn177BRlC1pfj5z5@penguin>
References: <20220401215842.58135-1-thepaulodoom@thepaulodoom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401215842.58135-1-thepaulodoom@thepaulodoom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, Apr 01, 2022 at 04:58:42PM -0500, Paul Lemmermann wrote:
> Fixed case statements which have more than one operation on a single
> line. Found using checkpatch.pl.

While checkpatch.pl is often a useful tool, in this case the original
code presents the information in a condensed but understandable way. I
do not see a reason to change it just to appease a tool.

Thanks.

-- 
Dmitry
