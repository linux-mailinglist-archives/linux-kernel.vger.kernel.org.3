Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D2D4B632A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiBOFxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:53:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBOFxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:53:21 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFCB764D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:53:12 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id p10so12483862pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MZiYIqQHTdeoJ9lebDmPlM5Q1GrE+XQWQNH/BfT5U94=;
        b=dGHJhJEtpRDhbHXpfGONB4RNX3MHZkVwiI5UWTvXOq/8hRL0jBHIgTLEKIA8mW9Avv
         J6e+oayJMm1r8O6eQ3FoXmJ1lL8wcxMW4uUfOh+oiDiYZcvgMJ9ik+XUUX1QsHh4qFBI
         VzfteXN/sxFNo9V1rCEOawnrc85LKd3vy2tys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZiYIqQHTdeoJ9lebDmPlM5Q1GrE+XQWQNH/BfT5U94=;
        b=MqAzibveh+AeRpgquT0HISCFzQgwltJSW4kfm6eshbBmei7lmywJVT38x3L61pymmf
         Mqz505tYrpxSq9w8kBOnd1bB+ovhiZD32fyl2C1GG5O5/Vt7LnqrRAlj5u0iYQsZ8YUb
         U2F1TjdGSvsjo9HwELgG95NFUUoHGU37M2xrv34ww5+f+8u0Kzvi52mqR82IS0J1aTFD
         biEyx8lWSUPPuCGJYWzoGEPZ5eSQo/x8lqDsP5nzyHRFDc/4K1Y6CWkrQGzBs9Ny0EEm
         6lSg1FJ6A9XpH0rKD2dVipzzPZiisyyEnN1fkWuWU1dAtzNvED1oXF2DcT3C/UIIP6HR
         g7JQ==
X-Gm-Message-State: AOAM532HTQ359fKf+xDdauVe1CGjnDyLOhatokMxnYOW8EpLBPuLnJer
        SwaNMT2vVHlGhIYOnho5XRmFROAeNYWvpw==
X-Google-Smtp-Source: ABdhPJzUCMq3k2+JQQ+iO3SXA2DubFgIifTx3H6vwjB03C0Bu9SPYtt3oqvAwP8d71cg0700rLfgTQ==
X-Received: by 2002:a63:914a:: with SMTP id l71mr2155987pge.581.1644904391827;
        Mon, 14 Feb 2022 21:53:11 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c926:4ee:add9:bf67])
        by smtp.gmail.com with ESMTPSA id m126sm155741pga.94.2022.02.14.21.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 21:53:11 -0800 (PST)
Date:   Tue, 15 Feb 2022 14:53:07 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 04/13] printk: get caller_id/timestamp after
 migration disable
Message-ID: <Ygs/w55BU8ZBt4Me@google.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/07 20:49), John Ogness wrote:
> Currently the local CPU timestamp and caller_id for the record are
> collected while migration is enabled. Since this information is
> CPU-specific, it should be collected with migration disabled.
> 
> Migration is disabled immediately after collecting this information
> anyway, so just move the information collection to after the
> migration disabling.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
