Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D149350AB8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442507AbiDUWgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbiDUWgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:36:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4665043495
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:33:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s14so6825634plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Ny4/EAYbX3qfaEmGZfS7iv79Oo6Wb3O6/res/i66KY=;
        b=mE0kCLZI0kFLBx8c/g9czQlmgWMFzkI8+4qgcblshEBoOrmfi6zBF5aj5oZ88D2g6I
         huvFmSZ9lGsNnnVgf1tJLKEfiucz47ZEQ+/QY4LxUNej5TFqQU9nrN+ZL2lUC7GimbCo
         0hD4G3OecR4Msu1Y3skUPGYm5I6+sMtpIoVpmh5kCt/N1nszRHyh2vn/VgyuZl8gV6RU
         Uv3lEEh27DXWc+45UqQAmo0tdgM1uHHjB4N5mN5gupSHOjxT0rXs5/mo5mS2Xbb/inSM
         +ypnxr7LN0a+3sG6fxctC/jOr9sV32b5yAUIXx9XfejN+DiGt2bcoR0xCmkSEnEWu1V7
         H7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5Ny4/EAYbX3qfaEmGZfS7iv79Oo6Wb3O6/res/i66KY=;
        b=l/GAkDos1QEfiC1dbN3kX2F7vkUC8MHCDb7AXkqt/HCQVGui2dMNPjTunUpE/pqByF
         7oKwLnobbUQWw6jECZGuUIZHnMNms80SlvXyHTCOOdAMJxfralolSUCsM2jQANmabGPi
         JlDaPuLdIv8im3H3knE7LioBK1rZkR0Zya4UaLIU34COguYVxQ59ceTf6cbAcSmakLLE
         D2DiUtBaUHtJ0UGUZpqGJEzbB9NM7uDA7fH6DmfcOpdqR32fBjiFYPxyQM/VgFjTvu2N
         y9i9x4+CpErFhuYrjos3Z2EyBNNsy5w7qk+D4Anv2I3vqJmLl8/PUi5u3udug1Zhn5+t
         k0oQ==
X-Gm-Message-State: AOAM530AoCls3BaTJZxjvz2b+w0kfxll7klfH/M/gtXwdl880gtGuL9m
        b84JH6XY3zeWBaec2PQpY2M=
X-Google-Smtp-Source: ABdhPJy86c5CvDcMpbiTJTIT8W8DhzHQeW9BmTR7qWhV8rK770x8n89/kQzYyLnTMi8th8EA306pNA==
X-Received: by 2002:a17:903:248:b0:155:ecb7:dfaf with SMTP id j8-20020a170903024800b00155ecb7dfafmr1652173plh.84.1650580432698;
        Thu, 21 Apr 2022 15:33:52 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:15fa])
        by smtp.gmail.com with ESMTPSA id y4-20020a056a00190400b004fac0896e35sm145005pfi.42.2022.04.21.15.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 15:33:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 21 Apr 2022 12:33:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Restrict kworker in the offline CPU pool
 running on housekeeping CPUs
Message-ID: <YmHbzrkWHbcv2CEK@slm.duckdns.org>
References: <20220331055717.2659428-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331055717.2659428-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 01:57:17PM +0800, Zqiang wrote:
> When CPU going offline, all workers in this CPU pool will lose
> affinity to this CPU, and may run to isolated CPU. like kworker
> in unbound pool, set CPU affinity of these kworker is
> wq_unbound_cpumask.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Applied to wq/for-5.18-fixes w/ patch description updated for clarity.

Thanks.

-- 
tejun
