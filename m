Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABE64C3ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbiBYBLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiBYBLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:11:00 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EA01ED4EB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:10:29 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id i1so3427172plr.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+qukDu2hliG7ObjC0OWtuj1Lxplxl2zZJPxYHSP6F6c=;
        b=NcbmMKlf5mzoy5eA24tSSETHUbiV0toqmg6GeSmb9ki9Uc9qj+grdPgCN6tBTuAwCZ
         0x3EkuKXFV/sSbRkntxRYjXHjRqSFgezI6AJE34PUysl1DaDaTi8lGob0+GuRURHvH62
         s2vKrQZeFVBkiffRqWBjn1KMDlAQCvQITmzyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+qukDu2hliG7ObjC0OWtuj1Lxplxl2zZJPxYHSP6F6c=;
        b=CdV/6/q/CDvCfNGnhHPwEfignv4xfYyyRIrVHEqUPwGq9+IPXQis9jFVRHW3hWD/Ua
         6dg+9a8S/gIzLPnCRpxEEW/8DkspDJ0TN/PIopupylJ/VXNlO0U6DsNHALpvA7WvKZPM
         bHt2aiMKfc6xzrY4sZ0mIWindk9RmY6dCHMvBnstqgZPF/+GNbodgXOvBQrahhDRfqoV
         HQ3GG0lh77f3bKZh7v8sMHJiVpK/b+Xs9sOsUWP2n3IAR/rOHwgLdIn53x+BccRbVWMV
         Omy3THlBbLDR6hDfC5TtCoQ47c0TYW+6HHVzZ9ze3d7X2Zy0blM2LkTpBR3N1CrB5ZNS
         nnXA==
X-Gm-Message-State: AOAM533rBEB+2n2tuJ7YERRFNPFac4EgXZqMO/xbgOMhSGnyp8CYmFCs
        ithve3LKhB98MEhbi0Q4QJKbjhZUeQUB/A==
X-Google-Smtp-Source: ABdhPJy+6f3iiQDuwfxf03qoIYkDcIrjYYJxMsbm/A+pvT0/Ns+/ZEoH2RQ9lFDByPu+yo77+9RopQ==
X-Received: by 2002:a17:902:cccc:b0:14e:e89c:c669 with SMTP id z12-20020a170902cccc00b0014ee89cc669mr5090327ple.58.1645751429023;
        Thu, 24 Feb 2022 17:10:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c9-20020a655a89000000b003747b9ed5a1sm682783pgt.49.2022.02.24.17.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 17:10:28 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:10:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 19/39] x86: Disable IBT around firmware
Message-ID: <202202241710.FCC4328@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.129392410@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151323.129392410@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:57PM +0100, Peter Zijlstra wrote:
> Assume firmware isn't IBT clean and disable it across calls.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
