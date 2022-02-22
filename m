Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA0C4C00FB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiBVSKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiBVSKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:10:18 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5D9172E42
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:09:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m1-20020a17090a668100b001bc023c6f34so305031pjj.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MpI+QTR5uF3hHf4Bz32+IS/VxWSVY5unua7iw2tRhM0=;
        b=MY/vtW3ixj5BU9FxhwE4xPZw7v8TDLwDtmESYmhbKmbENBU2uHhOqYkTXnejRD3t8b
         0jKaXB2gG63yb0pCHHEqTd0UDLRmTYnBJ15BvP11zbtwPsJqevTqYZEHo7ABbbnIa1WQ
         43P6ye86Nbsw0DOEN71dOFbzPfOu1xqQfxAsUAhW6CYPw7swPfjQPe6Zz9kq8XsWJWtm
         Nutxs3j0OSfHBT+USXXm1RaL1qCXXVX7nuKUUvub5IcigHFFr8Nhfi6xofxlPqg0TpgD
         kCfh2nkOxc03yRWfATpcllTQQ+oS1TqvQ8w6V+7srJuqoBgpbX+4fsafAJF7ZHLM3iID
         mIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MpI+QTR5uF3hHf4Bz32+IS/VxWSVY5unua7iw2tRhM0=;
        b=C5Yb+hNuVMUEL9KQKyVmjLJr8vktnqqrXoz5sRgn2ck+e7dQfnP1YZInfCenCoAMTe
         uAPg8G+WrNmRPNMbhTI78Ly0dchsOKgH9RbvHjGgwCXVPwN3qQuhIGLlD8mZnZEb8iCi
         lRpsKWadU2yYq8BUI+/ik/ZpSUde/AgvqeGCgawndh2zSpBF0+YgsFU5hoJ1vyJsf2I5
         02H/2nKvzz3bsJoUVUrsmwMXmfXZgaOY+XkfCXHxKwPmgz9qxWB7zret889AsqqAPotJ
         7zgythFH7h+QBaKS5dNIbj6Fc/vmx1CdPuK1P6GPCSFOhgnEAobD+0ZeE3wzSs8AxNLM
         ugSA==
X-Gm-Message-State: AOAM533M528Z3sRk/05upE1SOSPp4rjHvMWDR/LKd4sSOEhs3VHirX3F
        o+3vI9eKiOQ8b6QFNV/YArg=
X-Google-Smtp-Source: ABdhPJwiITEzUUWrciSmx1oxDk8DSXSPm6PxXeWk3NZMJCfFtMZGxO6wYfJwq47EIstRR1EMurvU4Q==
X-Received: by 2002:a17:90a:800c:b0:1bc:6faa:623f with SMTP id b12-20020a17090a800c00b001bc6faa623fmr4825103pjn.76.1645553392928;
        Tue, 22 Feb 2022 10:09:52 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id z14sm18356959pfe.30.2022.02.22.10.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:09:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Feb 2022 08:09:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Imran Khan <imran.f.khan@oracle.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] kernfs: Introduce hashed rw-sem to replace per-fs
 kernfs_rwsem.
Message-ID: <YhUm7yVBSoxACRUb@slm.duckdns.org>
References: <20220214120322.2402628-1-imran.f.khan@oracle.com>
 <20220214120322.2402628-7-imran.f.khan@oracle.com>
 <YgxXh3clQqpxUPba@zeniv-ca.linux.org.uk>
 <bfdef75d-4343-2734-2723-d8546df37c69@oracle.com>
 <Yg8Rq2H1C1ihFqds@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg8Rq2H1C1ihFqds@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 03:25:31AM +0000, Al Viro wrote:
> There are very few sources of cross-directory moves in the entire system.
> One is cross-directory cgroup rename(2) (already serialized on per-fs basis
> on VFS level), another is device_move().  Which is uncommon (5 callers

FWIW, cgroup rename(2) doesn't allow changing the parent.

Thanks.

-- 
tejun
