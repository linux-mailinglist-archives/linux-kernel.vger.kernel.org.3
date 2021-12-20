Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5334347A60E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhLTIb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhLTIb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:31:27 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83E7C061574;
        Mon, 20 Dec 2021 00:31:27 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r5so8755198pgi.6;
        Mon, 20 Dec 2021 00:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sxzh8vv+UDF1ozr4skh8dPpXzZBnoOuB4sgIDP3qnZc=;
        b=lyzkvbefg3LK3OejbCJKGaiCJ8IP2bqb4NE6s3tUteH2fP6IOx8fQBCNScfbwLK+zu
         Ae1iFgPPrGDIrTurycWjhFGmRXzzL6SrvACDBpLJWQhXnN1uCNTsXWqmoubuGSj3Tc5o
         PUCXiRBQPr15u+doLAbMKdI4xTM6lq3rPoGs27SWyeT8NtRsaUGoz5ys0Ioszm7Ww87c
         5pGerS5q/i6fZ2k7XneTCNrebgGQ1igr17Y3cGXSWtZcHNoEzH8QQLRY9nRN+3cHQ8s8
         AngMl1hQUolxSjke73H7vPW3YIfBLXivVFy2oT0eaQM1djrZzrbl6TaRpgTCFzsF6C+U
         h1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sxzh8vv+UDF1ozr4skh8dPpXzZBnoOuB4sgIDP3qnZc=;
        b=pnC0WxTlftRsavKA2Vg6qEQMxuvR4tLjE2BoxPX2xCH83g+aTPWhYg+eDW1lUS48Do
         d758G5Qvi84KDOT9bTA2WplFKC49fVJd6OnLRCM0ETLqvRkiXzhLQEUbtani297RN6RX
         HIunEguVHFKA/fbwkrao2/1Vss1CP5zhvwEZSlqb28FVGLV+hTY4v/LNUVkI7UseSl13
         xMzU8KrM3ENaDaGQ76vtGL0I/hUXU1LbpuxuTbWy0DEn2ie1nuG1qVpMLpaI5OaXeKEe
         NMXavdq5/PzZyz/54LD02JcNWDRzE6v3BRZJcuF1XONM0wpdu+EvG/kOdnq529WtVPvt
         djUg==
X-Gm-Message-State: AOAM533wuxu1vDrImz7/KJmEklgirf0z63UgsNQeiVzH/xrizHkzBSV+
        ohP/MKBUgRigSCt8pGhSMWmKS9QATec=
X-Google-Smtp-Source: ABdhPJzJVJN8fqxR1TBsbo2jyQreqtdnUPXezPHhgiIOE/Ndf22BeGYKLCs1dtF6WorWIM31o7pFPA==
X-Received: by 2002:a63:1b0a:: with SMTP id b10mr14202344pgb.183.1639989087134;
        Mon, 20 Dec 2021 00:31:27 -0800 (PST)
Received: from google.com ([2620:15c:202:201:3e2e:1228:8845:1f8d])
        by smtp.gmail.com with ESMTPSA id me3sm2627335pjb.47.2021.12.20.00.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:31:25 -0800 (PST)
Date:   Mon, 20 Dec 2021 00:31:23 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Johnny Chuang <johnny.chuang.emc@gmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Harry Cutts <hcutts@chromium.org>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        James Chen <james.chen@emc.com.tw>,
        Jennifer Tsai <jennifer.tsai@emc.com.tw>,
        Paul Liang <paul.liang@emc.com.tw>,
        Jeff Chuang <jeff.chuang@emc.com.tw>
Subject: Re: [PATCH] Input: elants_i2c - fix to check the Remark ID of the
 updated firmware
Message-ID: <YcA/W2wEk0wm7O8t@google.com>
References: <1639619603-20616-1-git-send-email-johnny.chuang.emc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639619603-20616-1-git-send-email-johnny.chuang.emc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 09:53:23AM +0800, Johnny Chuang wrote:
> The eKTH3900/eKTH5312 series do not support
> the firmware update rules of Remark ID.
> Exclude two series and keep the original rules to check the Remark ID.
> 
> Signed-off-by: Johnny Chuang <johnny.chuang.emc@gmail.com>

Applied, with minor edits, thank you.

-- 
Dmitry
