Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8527B49FAEE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349040AbiA1Nim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349025AbiA1Nid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:38:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3543CC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:38:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l24-20020a17090aec1800b001b55738f633so7290609pjy.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=is6S4jElVQxIZHKKeJ+uOPT+PZ499bwGOBOByve3Wqc=;
        b=pgdwWCc9Z8paSvapjeT876SWKb54JtsvY5vIptMdL1evVDEFpDSj5UWqDPJs6jKeAa
         G/NfGlgRl3Z6en35n4+FjhpHbD8hXjz8LNDX1ut2YFYjCK2Qsp1VjrVOmnBH+lnBsys0
         8Z1EGtkCBKxKwUS+OdtknAAj+sHFz5NvsFCmPPuakhSdsyYumm2c1O4U8RM+ZQPZ7l6r
         FbgN1AjTCEjDmzvg9PMBXoIX4JULIGsnjIl2UyoGYDCi8LT9YJDIUyhQmYJUwXGAWvUy
         5I947V+twaWqFmR5FOnYfxV8kqVMYA52EOOvRkeJckK5M9sMPleOQ1fm27nTWarRfxTW
         lmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=is6S4jElVQxIZHKKeJ+uOPT+PZ499bwGOBOByve3Wqc=;
        b=FCSHz/cKA5Aygp9jA0DFyaKf2tQmI/v8KXn0OryB0n8Mk3cGSMcNkNDmwjVoCaD6g0
         BLXvfhLrQxuE0oLEQYMpypbmVPzHzn6OG1K0gIDPweIkJsPDI4o7HV/guZUDVQZ9O6GP
         U5ejB3WUW3jFbL52qmdLG8DI8mbnrGBowsjln8Ww5EqCdsf1rHCx4Q7V92xoQ/rQcNi8
         6PoY9tyd8e3sd0kYFwRg7tngYyVFzJDs+ElZpfcmeb3fvD2/AIrWQtlZMUQuMFXdafEL
         YXegjaChmMYHzhKZ0qG8MGi8wNPhobjzhHoEjSj9CmXsbH85+8kY2ASTq+zX/RJq4jgp
         pAig==
X-Gm-Message-State: AOAM530vL3HSViinTShwJIFDfsZDOi1gz5+56+xraejZsLfQ9yErbueS
        pI8DZHFp9QenivQFuN9fLmuScw==
X-Google-Smtp-Source: ABdhPJxJrzuPfUKSSu+77kxCEcP4C5CMCDjHXJgujfWUfsNG4a9hKWqGRmbMvVVK6rcQonP73yOFFA==
X-Received: by 2002:a17:90a:4811:: with SMTP id a17mr9839741pjh.159.1643377112676;
        Fri, 28 Jan 2022 05:38:32 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b14sm10009771pfm.17.2022.01.28.05.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 05:38:32 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20220128043454.68927-1-jiapeng.chong@linux.alibaba.com>
References: <20220128043454.68927-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] block: fix boolreturn.cocci warning
Message-Id: <164337711017.260343.398701118435973656.b4-ty@kernel.dk>
Date:   Fri, 28 Jan 2022 06:38:30 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 12:34:54 +0800, Jiapeng Chong wrote:
> Return statements in functions returning bool should use true/false
> instead of 1/0.
> 
> ./block/bio.c:1081:9-10: WARNING: return of 0/1 in function
> 'bio_add_folio' with return type bool.
> 
> 
> [...]

Applied, thanks!

[1/1] block: fix boolreturn.cocci warning
      commit: 7fc6fce0c96ff6db540a974b9b9dc38e241543a5

Best regards,
-- 
Jens Axboe


