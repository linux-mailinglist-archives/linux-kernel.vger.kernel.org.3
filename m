Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42FF4DA880
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351419AbiCPCib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiCPCia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0B2148E63
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647398236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bvE1D2NOSQG7Tkh9PJFE2DBIbgp7cnI0DFfAn6V8XKk=;
        b=dS7KoirzfchIxQXMH/S2ooCSSOuDa2KNJdJNNRbLP41/k6p5MqQcYHsg9J2VcN5wDmUyHw
        LnSBtYl6p5jFst2oQNXUMjD+/zO5WuQ1aLEEWPzVnsqDkBXuo2+mD6OYxzdFgMGgKr/4C8
        pwe/PvVio7hueBXOVLQWvFLgxofgKg8=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-2ebCGsi2M_KTjaePrARf3Q-1; Tue, 15 Mar 2022 22:37:14 -0400
X-MC-Unique: 2ebCGsi2M_KTjaePrARf3Q-1
Received: by mail-ot1-f72.google.com with SMTP id c1-20020a9d67c1000000b005b2353e2c03so464680otn.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bvE1D2NOSQG7Tkh9PJFE2DBIbgp7cnI0DFfAn6V8XKk=;
        b=UhN1s1JAH/pjJN4l4s/sLxiaqIFIu1/SIGAfggPHFbgdnW0vyZObdsXhIV/0j4JJJi
         W7WSRz6sCLGU089+qJ5Bqzzu7vn3PVBO0g+x9S3akQ6u0VRKfLE6B171X9JzuxrMPk7+
         Uo3ZlTE/npQxlKkR6mxnSHNTnkyqZsebz6eHnPgooUltZg869yAJ6vv0CO6eBgJbsEdN
         H7xfIvDhK7mZpIpOk+xSCuvksVLqc7RrKkman17e6irLU3NWXngM2x5S/h7aG/7LGycq
         WA8YQV1M+tD22NKvBaOzwy/LUsf2w+HNMo/4t19ioHAPgaGojTVK5hu9rn7VdJORJi0Y
         BhWQ==
X-Gm-Message-State: AOAM533+mVUg5wmJa+/iKtlnajkQEAyxs3ovOxK4l1DDV8E1M+mqQvOo
        tDO2oZeyW6ZLCtDClZOKWJEQ3fYJwiS9Yzz6NaLr38940y2JADX7994VmRjrR5BTn5mqgixI4eY
        WwIuLWSIL5otvZPAeJN2QSyUv
X-Received: by 2002:a05:6870:64a8:b0:d9:aa23:8ef8 with SMTP id cz40-20020a05687064a800b000d9aa238ef8mr2708453oab.49.1647398234092;
        Tue, 15 Mar 2022 19:37:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSRWt0R4GpGV54gpiFTz0JldpK5bi52zWlHR0hKHPl016thUFZ1N0ByTNP03bU6g531e6Ggw==
X-Received: by 2002:a05:6870:64a8:b0:d9:aa23:8ef8 with SMTP id cz40-20020a05687064a800b000d9aa238ef8mr2708446oab.49.1647398233884;
        Tue, 15 Mar 2022 19:37:13 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::48])
        by smtp.gmail.com with ESMTPSA id l31-20020a0568302b1f00b005b272c60230sm350654otv.40.2022.03.15.19.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 19:37:13 -0700 (PDT)
Date:   Tue, 15 Mar 2022 19:37:10 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V3 3/7] x86/entry: Switch the stack after error_entry()
 returns
Message-ID: <20220316023710.jqmi666o6cqyoonh@treble>
References: <20220315073949.7541-1-jiangshanlai@gmail.com>
 <20220315073949.7541-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220315073949.7541-4-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:39:45PM +0800, Lai Jiangshan wrote:
>  .Lerror_entry_from_usermode_after_swapgs:
>  	/* Put us onto the real thread stack. */

This comment is no longer correct.

-- 
Josh

