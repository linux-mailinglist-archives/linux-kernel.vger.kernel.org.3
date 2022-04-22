Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C145E50BD0E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449694AbiDVQcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449709AbiDVQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:32:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB085F24A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:29:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso8293164wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSXwiLWEWjQOdj+ybEhSxWqUg5Aax1i9HRhflZyjuwo=;
        b=YCU9p6462BVx82HSLv9Rf5QhBNUN0F8YsJmOSNG2sWhZmCf1cXergh6irXe9A/wyEn
         6MNuFfw8IkFKwTdu6Rw+ue6TJntl7y47Qnm1B9Aq0IzM9re4QeMDFJ7BPFsKuMNWXhxI
         qUAMlh2gxQm3v7wHRPs9SGge4q8MFimzFQPs5L/vK1xKaDuwTZmPOB0hixa5HFf6OAkN
         6gpZ6/opOqYIVv8BsnEWihRUFm8Ea9nAHtpMr9p69y15/M0lXX7FLzEk2Fv4ki8S3osQ
         BAqbRK/e/4InBnr8JBMUoaX4U29jks4nwhKPkZFZmy2/vARNJKz96fhyw18tqKOSekww
         LkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSXwiLWEWjQOdj+ybEhSxWqUg5Aax1i9HRhflZyjuwo=;
        b=jfyGWCs6t7CI2wO+dNmZ9m9SiO8Sad5R3YzBr/7buZB8jBD3oVm1p/vWpuxZKZ9ul0
         cvqCwXG6a8o5zo0a3nZO/W6GnQA5cv3WCmuE50jeFQpKWcg++IHZi6p5CCJ05QfNCMhD
         siR+Sgpb42BqVccCJAyZi5AH5YHDyi8pIRqrGeM/dbe/+Yw5nEOl58u/nM/Kd9JGUwvs
         ap45EVkJhjCqkv4AjWEkCfck95Bn2pz0DCuDGtcaGDSrpL3uJGPpSDsv3BqnOBuKsE6U
         mbukLg1PpVtu3t7L6T4nFsD7YsW+2v9B70VFC/B2STCCTy6/dsIzbDmYaFeQqIuz7uk9
         4grw==
X-Gm-Message-State: AOAM5331NcgD2oz1BVuyOoYQS3sXcvJipxHtwcN5wSBfonkx0yv/LRpY
        qry6ITp3WB1DPJJNVD/HjXTQsutFPooStx1A8a97
X-Google-Smtp-Source: ABdhPJxQf0nrVX6OvvkN/qAXo2l6q28oSGFqJEwPgjpsntDi6y99ItonZP/WXwbNbd2zYvOdWqbpvOTiwT37SYWMkC8=
X-Received: by 2002:a05:600c:4fc9:b0:392:8906:7e5d with SMTP id
 o9-20020a05600c4fc900b0039289067e5dmr4839993wmq.179.1650644963298; Fri, 22
 Apr 2022 09:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com> <20220418145945.38797-28-casey@schaufler-ca.com>
In-Reply-To: <20220418145945.38797-28-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Apr 2022 12:29:11 -0400
Message-ID: <CAHC9VhSzk6dq9wbhAtv07XvRvFwD3yZJ5qAPHyLBHV4Kh1eUHA@mail.gmail.com>
Subject: Re: [PATCH v35 27/29] Audit: Add record for multiple object contexts
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 11:14 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> An example of the MAC_OBJ_CONTEXTS (1421) record is:
>
>     type=MAC_OBJ_CONTEXTS[1421]
>     msg=audit(1601152467.009:1050):
>     obj_selinux=unconfined_u:object_r:user_home_t:s0
>
> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> the "obj=" field in other records in the event will be "obj=?".
> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on an object security context.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h      |  5 +++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 47 +++++++++++++++++++++++
>  kernel/auditsc.c           | 79 ++++++++++++--------------------------
>  4 files changed, 77 insertions(+), 55 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
