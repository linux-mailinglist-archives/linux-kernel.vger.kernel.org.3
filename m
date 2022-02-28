Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8877B4C715C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbiB1QLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiB1QLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:11:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07DC50B05
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:10:41 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b8so11547007pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xocpR3kEH7DQeX+jVuIfF7VJPK+XVL0jIQPIFfI+qI8=;
        b=dhWajjV0N5cq5yyksodXUrVKqdANsgBSLIQvn6xHJ/0QOeLBz9xHBvcih5XHYq4rwA
         RjOE1R+evHHmluSZlnSSq4lLGsysvjA8UqkOjKsDzbYJOpGxH2RJgXtRvL4vdwbVgHzg
         gHU4l5/orEAqiO7t5Ktm0UIOq1L80gDqgaNnBpIc4Dkkm2TYy83urB/fGjMVbffjDwLK
         zR62D8b8lMFEkREryoau4PxGO++jLEhQruLdCXq+gDWpH3N7FdWWb6BziaEYdQQwa6wu
         AM0YJIJ8qu4g56p8oeb5l06IATj+NIbNVM+zTCy4uVrqOXRkQVHuUlGSbo95jlUS1jZJ
         UJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xocpR3kEH7DQeX+jVuIfF7VJPK+XVL0jIQPIFfI+qI8=;
        b=FvGw9G1LZCOhqgZmtOl+9UjTvNAljerdRObeWSmIz6wT3QAZ5A+2t8k21dJXYPWKaH
         nTIT3xSPOm3RNyX8abcNteeIKIzw5KEZ97FhuiyqmPBQJRHvXEQHHe8mZLrJOhENI88o
         PlF/EHAZHKyqY0D5qbegdhg9aJGwRdZa9fdV1kToViKxUeAvr69Q1QD9ud15Pf+iyvnQ
         oHG6o+UfKOTfVSe31xIGLXgqZxy0ShqAI+jtcU9VUcLU/QEQj48GPkr9VyBtGAvpUuoU
         g5t0ZFjHrVS+FvRBfYpqoZXULjG4yp39v2LXvtRSK/KhgWvC3cZjZx1Tz7uEjfed2rgr
         iTjQ==
X-Gm-Message-State: AOAM5328erTrGM/RRiaCJ7km4XsMN8imx8GtIzTPLaxOkcSCL0bYYNDm
        VbX18+MHXHO0Mbyqf1kNL/WL1g==
X-Google-Smtp-Source: ABdhPJwnEoEFSQu22qln1XnyXWA2QCP/IX2mziXAw1Oqr39CegYdEMoSIFcdf8UlMLnZXFRXtC0IQQ==
X-Received: by 2002:a17:902:ec92:b0:14f:e593:5e99 with SMTP id x18-20020a170902ec9200b0014fe5935e99mr21508133plg.42.1646064641053;
        Mon, 28 Feb 2022 08:10:41 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n42-20020a056a000d6a00b004e1a01dcc35sm13805049pfv.150.2022.02.28.08.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:10:40 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:10:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peng Hao <flyingpenghao@gmail.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  kvm: x86: Adjust the location of pkru_mask of kvm_mmu
 to reduce memory
Message-ID: <Yhzz/N4+3vNh7AQn@google.com>
References: <20220228030749.88353-1-flyingpeng@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228030749.88353-1-flyingpeng@tencent.com>
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022, Peng Hao wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> Adjust the field pkru_mask to the back of direct_map to make up 8-byte
> alignment.This reduces the size of kvm_mmu by 8 bytes.

I'd prefer we just burn the extra 8 bytes, at least for now.  'prku' and 'permissions'
are related fields, IMO splitting them to save 24 bytes per vCPU isn't a good tradeoff.

And in the not-too-distant future, all of the 1-byte fields will hopefully go
away, at which point were "wasting" 4 bytes no matter where 'pkru' is defined.  'ept_ad'
can be dropped immediately, I'll send a patch for that.  We should be able to drop
'root_level', 'shadow_root_level', and 'direct_map' once Paolo's clean up of the role
stuff lands.
