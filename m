Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30740485932
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 20:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbiAETci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 14:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243540AbiAETca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:32:30 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D190C061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 11:32:30 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id 9so328920ill.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 11:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=qpCxtfwyVwBIee1PBexn3Z3InR/064lKrv4gYmq0iEg=;
        b=W7u+wiQHn79Ti242OgCMKDUwuBUEcwO3WrLpyVELKVQUsGM02xzlhOmH4Btz8Zo6XU
         lxvQwfPs96IbaCkCFCq61GpwsM4uT2Jq0eYYXWUaC63yRStHgClTP8WQF/wfaiGtsxlB
         k8z5Y0VaoVZCD295+pgtNGIfOi4dPaYrpBkpVFaUKklOh3X6JG0W6gXO/x0JPmArQMG4
         MPEFjPZv0bSmXr0RYA43pW817W0TCRh3WwN/qwPgW3EH3gYQTp+1s6jiavkCZA/u0v2a
         MXSxzhTEZ0i8viw+qytehIKE/7osM1ESsiPhO9AvDqS2UDo9Eas8lMU8o3JLlcllQ92k
         d05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=qpCxtfwyVwBIee1PBexn3Z3InR/064lKrv4gYmq0iEg=;
        b=tRO6Pjc3bF0A9jKsKN2mE3APACZAieaEt5Lm85VQcvycIOXlVlXBBcTY4bt+PV0njh
         GhjC0YDjs+o8odlbN6bGsPwbl7IJfBdovFSzHOAkxx0ahsX7qtrVpYafaMPfiM8BG3YC
         +hxq07g9Ml4gKVi9nzUtt476PtYLwx3R2lhb9RS7xegvHg5XNmsIM4wNEfPhCL8ZlDmT
         zk3yQ6Zt+G1rqjgcG2Yao8p6fsf8nimS7Wt0wHfur3SZitvXEohZesPaUAu5jI34xEev
         3oZZuIoq7j3Pg19CrPuXI9RVkgxCfhhAgOfqVQUhF1zPfdaR8TNK72qwe7rVvxluubMG
         QvqA==
X-Gm-Message-State: AOAM531n3ZoaVLlrqa+GAGIeLtLezgiRilX/H0POj39wYGsDjOZPQU54
        5VUo0w3ssZWe29qTIH5mVYsomQ==
X-Google-Smtp-Source: ABdhPJwFb3zv4DUiGeu9ejxwMSGKd4PB3tS78fU79SVD8P7c1pBDEfYPEx9omtq3DFe8IXXA6+V74Q==
X-Received: by 2002:a92:c510:: with SMTP id r16mr1237447ilg.74.1641411149774;
        Wed, 05 Jan 2022 11:32:29 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 7sm27406883ilq.23.2022.01.05.11.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 11:32:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     GuoYong Zheng <zhenggy@chinatelecom.cn>, asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1641377585-1891-1-git-send-email-zhenggy@chinatelecom.cn>
References: <1641377585-1891-1-git-send-email-zhenggy@chinatelecom.cn>
Subject: Re: [PATCH] io_uring: remove redundant tap space
Message-Id: <164141114909.317320.15522175308443944192.b4-ty@kernel.dk>
Date:   Wed, 05 Jan 2022 12:32:29 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 18:13:05 +0800, GuoYong Zheng wrote:
> When show fdinfo, SqMask follow two tap space, Inconsistent with
> other paras, remove one.
> 
> 

Applied, thanks!

[1/1] io_uring: remove redundant tap space
      commit: c0235652ee5194fc75926daa580817e63ceb37ab

Best regards,
-- 
Jens Axboe


