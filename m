Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5F64F8C16
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiDHC5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 22:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiDHC5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:57:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6772E75A2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 19:55:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bx5so7384686pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 19:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+KACtupekOqWzn/zinGRfIt70LMM9pPdiHf8+KXBdp0=;
        b=n7GjVukDtuF8wAOKxI5qi0lfKNZjaZviP4zJsFr2zNsA54fhegeTNLDWn0mRLGhiMg
         PUPMcfQibs8eMDRCLfF8o1fx82nmrzJR4GCh/jMm0LQ5n5ZpkioIBjhhlVo0NwwtQmGc
         doyZxx9JMouPj0v8LMg9TnB2LDLqZzzehJVbDadUVP1zLr8OVwBGzBxEQJqGHzoxKy8h
         NA5xb2Tni5qDsJGLbS5kRdDFYv1VoEip6UMNGRmtv9moEBM08t5WRDIutRCzH99rb+Gt
         8JWDvfWFwN5VpUPnfdHgz9TuXM8kE+eIVzymmM60CGD+5W4hV02O5koTh8dgwoqMogJ/
         ouLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+KACtupekOqWzn/zinGRfIt70LMM9pPdiHf8+KXBdp0=;
        b=dX3O8WlGFTGp6RvJcm9ALN0G+6wLGxxXRiXnhCgicTNGYkuCTKrFsM9/LKJztz0zmw
         5osIkrnHs8HH22xfmfJjeiMg7kVzOI2mdV8ldqEpxaUjKx9ok9Um/OYKOU5yOzAO72mf
         owSxwoj0/M+qTsI0g/Y8V+AaacYvdeAwhoqrlIDJVg6fa6VDLr6HldfNEoaI31Hl475t
         xwEzLOyyOB+sz9I8S+Y3i9XnZ3+w6qesjtswma/FkVaoxqYK/J85PsG749eQFwZy8572
         tfJJQ+VBW5gGBDCEhSY2LAvnnR8n+fdiNmfKMzH3jlgsDTVb3RFvphgpAt+42Evvte6A
         8XUw==
X-Gm-Message-State: AOAM530FTrpIZj1sG/PjF4FYDpYLzfKoZhy0jYJlItrqX3aZ5kcn+5VO
        Ltf0d/X971LIrViDsprJlnQEEnHYvIl4oA==
X-Google-Smtp-Source: ABdhPJyrQu1b1JnWN5WneWpC+wVNYkvXnuCgz09mBClKlkOltg4Mi6CvPV4uv98tS268nP+zzWMNSw==
X-Received: by 2002:a17:902:b684:b0:156:80b4:db03 with SMTP id c4-20020a170902b68400b0015680b4db03mr17270771pls.16.1649386501966;
        Thu, 07 Apr 2022 19:55:01 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a00115000b004f6ff260c9esm23639716pfm.207.2022.04.07.19.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 19:55:01 -0700 (PDT)
Date:   Fri, 8 Apr 2022 10:54:57 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: Re: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put()
 completes
Message-ID: <Yk+kAUwxZx1JhxIu@FVFYT0MHHV2J.usts.net>
References: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 06:33:35PM +0800, Qi Zheng wrote:
> In the percpu_ref_call_confirm_rcu(), we call the wake_up_all()
> before calling percpu_ref_put(), which will cause the value of
> percpu_ref to be unstable when percpu_ref_switch_to_atomic_sync()
> returns.
> 
> 	CPU0				CPU1
> 
> percpu_ref_switch_to_atomic_sync(&ref)
> --> percpu_ref_switch_to_atomic(&ref)
>     --> percpu_ref_get(ref);	/* put after confirmation */
> 	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
> 
> 					percpu_ref_switch_to_atomic_rcu
> 					--> percpu_ref_call_confirm_rcu
> 					    --> data->confirm_switch = NULL;
> 						wake_up_all(&percpu_ref_switch_waitq);
> 
>     /* here waiting to wake up */
>     wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
> 						(A)percpu_ref_put(ref);
> /* The value of &ref is unstable! */
> percpu_ref_is_zero(&ref)
> 						(B)percpu_ref_put(ref);
> 
> As shown above, assuming that the counts on each cpu add up to 0 before
> calling percpu_ref_switch_to_atomic_sync(), we expect that after switching
> to atomic mode, percpu_ref_is_zero() can return true. But actually it will
> return different values in the two cases of A and B, which is not what
> we expected.
> 
> Maybe the original purpose of percpu_ref_switch_to_atomic_sync() is
> just to ensure that the conversion to atomic mode is completed, but it
> should not return with an extra reference count.
> 
> Calling wake_up_all() after percpu_ref_put() ensures that the value of
> percpu_ref is stable after percpu_ref_switch_to_atomic_sync() returns.
> So just do it.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Are any users affected by this?  If so, I think a Fixes tag
is necessary.

The fix LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

