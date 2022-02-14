Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CD44B3F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbiBNC2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:28:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiBNC2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:28:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244CA54BF2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:28:02 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b8so1263038pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eHVx4eLp/6ISyVuihm54WwbAKNGvJ983iADmphW/zKc=;
        b=nKboMwFKZCe9HZx80EPoeTvUSHVDMiVALiW/wfeBAlBI41ECdPTcx7AfFyRMzR8vxp
         T4T0jLx5kQ/UmqK/k0MtSNkwXeE1cb41bmkbh66G5lilXsmx8ij+xLuV9wWjTdmNtsYm
         PUy0fB4fn1zFWveEZXj2oKufulhQja5cQeCmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eHVx4eLp/6ISyVuihm54WwbAKNGvJ983iADmphW/zKc=;
        b=qgkDn5eMnWxEONnARQe2EGSEwXTY5N0rFjRV85Tu15sPuakC/5B05CI8mAser38PGb
         39xGvCxkiR6SDuloPJA3ln0yntwZb2mQWHnUCM/HjYZ1OxBd9BKvXkRALVg1Cjp1HQMU
         qoOQqt0j2NMsoLB6RMsqrkQhtvdVH7w4bDxDZow6HgxvStn+fQBWoR8s4SvwIV4goFpo
         RzZVvewi8x7mj8gjR+IvvWLXRbotpQwjPLLLBvk8UVODNwdXQGIuodevM3512yVqwgdA
         S3YP4Dawne6js+A2wegKZAqcf0s7ZcJawfQs+u0g85z/3s1c2h3t6FUeimCIoxk5MjJy
         t9gQ==
X-Gm-Message-State: AOAM530gBvJdhHeKvkXFnoPvRV8n7OSnriTclv1R2DSVbrzUGUZVKw1F
        +PViu8jybQG4ziUGY8TRIt2BxQ==
X-Google-Smtp-Source: ABdhPJwQl+6MBWXgxLd44lNSi5ZPoaDpFPzTTpmMbtSw3PMIW1VPAWeDH3KX/wRFGj3RQ8ab0i/sow==
X-Received: by 2002:a17:90b:350e:: with SMTP id ls14mr12300900pjb.51.1644805681718;
        Sun, 13 Feb 2022 18:28:01 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b736:df7d:23c5:206e])
        by smtp.gmail.com with ESMTPSA id s32sm27235238pfw.80.2022.02.13.18.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 18:28:01 -0800 (PST)
Date:   Mon, 14 Feb 2022 11:27:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v4 0/4] printk: reduce deadlocks during panic
Message-ID: <Ygm+LdZDmIJCysgs@google.com>
References: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
 <YgTZPQEay6T/nhu6@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgTZPQEay6T/nhu6@alley>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/10 10:22), Petr Mladek wrote:
> 
> For the entire patchset:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

FWIW
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
