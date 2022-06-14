Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6747954BCA5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345042AbiFNVOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiFNVOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:14:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF53D50041
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:14:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so1997333pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HkQPTB8t9EvGTKD58qF0vHfJ68oz3l8jIBkren14MtU=;
        b=aTkpA5a5N6RUC9vd4bhLfhbhY/dz8q6pNmobzGI2TMh1aU1jDqxRo5Gxd/Zft8SmN6
         SIhZMRCGAIy+V/TMcqBK7WEhxm0SkwnT2JX22dhc4C/53+O4dm2pbpCriM8kBPoGMJdV
         GHRSx3d9WBeM29p9VR6/Z2Nas89KWs9bNq5AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HkQPTB8t9EvGTKD58qF0vHfJ68oz3l8jIBkren14MtU=;
        b=IozS5oLp+GALU3U6ipc4cS6pcg2aCBPlYEx3+v2Q98IOLh9djM8yE68/iYKggHdH/K
         fpY88yiIn8gvXY9ilK2PCFVHQQStGDqCInqmgMroO9Wp0etz+wib+eqXYoBNkOg17JMO
         RkCuavNcfSv5i7Qhg8vTyUODtYeUjwlNsZzdo6WZMKbxoW3IXzRY3mcwPtYo9e01n2G/
         iCKYePftUPE860Cbw1LRfRzvQzZWqQ9vgwmDdOJDB1g3EMTZWOhKiiVnLxRuOitO08+N
         cdu11zNo6+cIHqOqK432Ce10OSPZitihSdQiniuEVAX5mHXcz0m82Q10qOyVAMoI5N+n
         gLWQ==
X-Gm-Message-State: AJIora/5vkvqndcIOk1nuoVD3iMQkb1zZtpE6w2pL2Zjdy1d10Ypmsb5
        qMyjEfTf1U1xGVeUuJ7AzYDT5kMMPsG+Ug==
X-Google-Smtp-Source: AGRyM1uFBH5wfa41P6XfONQLES95sTRwU3lihAbKYJg4LX3fASGK2gpnxJeeDBjDXT40OVpTGzCeNA==
X-Received: by 2002:a17:90b:1e42:b0:1e8:7669:8a1c with SMTP id pi2-20020a17090b1e4200b001e876698a1cmr6476478pjb.206.1655241276404;
        Tue, 14 Jun 2022 14:14:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b185-20020a621bc2000000b0051bc22c153asm8054589pfb.65.2022.06.14.14.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:14:36 -0700 (PDT)
Date:   Tue, 14 Jun 2022 14:14:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] fs/exec: allow to unshare a time namespace on
 vfork+exec
Message-ID: <202206141412.2B0732FF6C@keescook>
References: <20220613060723.197407-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613060723.197407-1-avagin@gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 11:07:22PM -0700, Andrei Vagin wrote:
> Right now, a new process can't be forked in another time namespace
> if it shares mm with its parent. It is prohibited, because each time
> namespace has its own vvar page that is mapped into a process address
> space.
> 
> When a process calls exec, it gets a new mm and so it could be "legal"
> to switch time namespace in that case. This was not implemented and
> now if we want to do this, we need to add another clone flag to not
> break backward compatibility.
> 
> We don't have any user requests to switch times on exec except the
> vfork+exec combination, so there is no reason to add a new clone flag.
> As for vfork+exec, this should be safe to allow switching timens with
> the current clone flag. Right now, vfork (CLONE_VFORK | CLONE_VM) fails
> if a child is forked into another time namespace. With this change,
> vfork creates a new process in parent's timens, and the following exec
> does the actual switch to the target time namespace.

This seems like a very special case. None of the other namespaces do
this, do they?

How is CLONE_NEWTIME supposed to be used today?

-Kees

-- 
Kees Cook
