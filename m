Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3073A4FB21F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244472AbiDKDEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbiDKDEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:04:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8013B6171
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:02:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f10so12706992plr.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1ttV/WVSYVNPGdQ6oriwK73UP1vuMqUqaSXFIdAM9p0=;
        b=fa75EuRwkJR8qLhCtu2GdbogdrPVVPSco/FQKW6BtLaWHE2TmfCnSynIKa3v17vXyF
         UhnXk6ECC8NAUVmWyepUMoHToHHXgWjkSekBH+A1BfwtXjJsZwUsAVpK3WSyCZfXfyEA
         3hf/CAaSrhXl6m7dhDLMDkyro1xYLOFLOxFslF14VIJgenP8bpw5yMN8LHcTkfheR9Mj
         JxeL2MaQOvtDZP9UnAFK5ga9a2j69brXj27Fko6kuhvX3iJLlsm8Pq5rZRThSe6eAhqE
         8BJjAexp+2WZNpSpEkvOf24Wu/wB60Xd2BA+Szpj+KaNo/12IXc+lLsTDW7GidBBjxac
         5B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1ttV/WVSYVNPGdQ6oriwK73UP1vuMqUqaSXFIdAM9p0=;
        b=XTVZ1r2lvUwptD/e8BATGs/Vcl2loEjYO46cLekl+ICCh+/YPWqVYxMU7Cxks2DEsi
         KKr1Uuz98pQlbiTU002fD14DRDkr46D8bjIglRcQCr2ojmvanfDT3toOtOOKtXTWKKZ8
         BIo1m8S07AVYL/yw7B5ZHnEQ8LMMOrbnEBk1PN76012pPxMoOfNus7vM3W7RFiA7VUDO
         tGXwVz4sFrlDLvzD7jKxo9LtN0Q4oWs2FUsZthDq7FQ9Z0Ceb1a6El1ogH8Ekr650Mrr
         /Lq6oslgRLNiCFU9NoMYmyEI9bwE/7nRuvOqaq0Q5qqekZcUDFbaI3qYaplHyZru5J9a
         n2xw==
X-Gm-Message-State: AOAM532p5PUPcpOBjQzn14uptON0ZlckQygyQydMUGEGQpn/aLLrpwDh
        Z52iH79E4O/TvqaH9iua/ByrNQ==
X-Google-Smtp-Source: ABdhPJwyVsYJmOUEZkD1Z0FmJ9ix4p6BY226TpTEzE5Y7X9I5RgMCwy3ka10rWKdgV6GYXBnOl0DNg==
X-Received: by 2002:a17:90a:db08:b0:1c9:7cf3:6363 with SMTP id g8-20020a17090adb0800b001c97cf36363mr34724813pjv.35.1649646127503;
        Sun, 10 Apr 2022 20:02:07 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id pf2-20020a17090b1d8200b001c6f65ca66fsm18735683pjb.47.2022.04.10.20.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 20:02:07 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:32:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] opp: use list iterator only inside the loop
Message-ID: <20220411030205.gbql43daeky63ebr@vireshk-i7>
References: <20220331083018.31995-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331083018.31995-1-xiam0nd.tong@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-03-22, 16:30, Xiaomeng Tong wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate dedicated pointer variable [1].
> 
> In this case, use a new variable 'iter' as the list iterator, while
> use the old variable 'new_dev' as a dedicated pointer to point to the
> found entry. And BUG_ON(!new_dev);.
> 
> [1]: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> 
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---

Applied. Thanks.

-- 
viresh
