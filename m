Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443834BC045
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbiBRT2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:28:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiBRT2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:28:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EF5A35865
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645212484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tVPxjcBKjblF94M4zqPXEufqxdKrib0BB4ddOMFEM08=;
        b=cnV50EcmUTNDIjn4j5Ot3bgCtLlFmypc3td4MuIxQBF9lgkpKIfzKEsBf0jAXFsoMP7JX5
        dk2X4evl3RMZFtvbjWbFyRkUBK8/EVqOi95PCOvWM1cFo+59999QhetwmlDdJteOVQm6Ou
        9F9mcVtaKhn+bhIDZOyDGhck5xB7gBg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-S5zHoRv2ONelow0-C-Xguw-1; Fri, 18 Feb 2022 14:28:03 -0500
X-MC-Unique: S5zHoRv2ONelow0-C-Xguw-1
Received: by mail-qk1-f197.google.com with SMTP id m22-20020a05620a221600b005f180383baeso8242130qkh.15
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVPxjcBKjblF94M4zqPXEufqxdKrib0BB4ddOMFEM08=;
        b=lKaL9sK+UV2SPLI2Zje2FSac+nNUYTH0L7EAcg26BUpzq5DqmS2bK3JFF7+9IUCyez
         EPtNuFXKW1Yw8VVgztxq9M6rLS0CBV+l0A86BmjnuFZUTLEqD3t6Vxt0reoRSlElYyxY
         jJENHqPAGS0PchasBvIg4zzGy9sdz1vBisXpRHOg7tMlSyH69mH7Jd3Rn8zd2zIbqHk1
         tuC2zL3nSmAfGefBgfm66Y60QV6/4YFwCDf58iTsXmk4FfuK4tD70xPTlDoNJLACJ+U1
         QZves1cqCI4b7ms369208QDtk6q5/S3WeLSL3k11JDnKKB65qIjqS5FbchwrIxsgLM1n
         cj1w==
X-Gm-Message-State: AOAM533/HJY8qcprJ8BHZrKKooocJKQzLcnij1tr1IXto8HwmSbvk0vs
        UFtGV9WzNfJYerFNhsbAKK2G5cWSDBOWCJUk+8HSD+8btXy9GKHY1oMgwBGOU574VwNUnogruOz
        fZVqz5DhU6uOEedxDUPLAr4kj
X-Received: by 2002:a37:9e87:0:b0:4e1:1921:1f9f with SMTP id h129-20020a379e87000000b004e119211f9fmr5600615qke.480.1645212482589;
        Fri, 18 Feb 2022 11:28:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYH8qpJkU/O50c6oYrriIVP5cRNhMrkKiN6+wB62DYbVc8bGOm25BG6TAPzao/TyTSJah5/g==
X-Received: by 2002:a37:9e87:0:b0:4e1:1921:1f9f with SMTP id h129-20020a379e87000000b004e119211f9fmr5600597qke.480.1645212482354;
        Fri, 18 Feb 2022 11:28:02 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id z127sm5064723qke.106.2022.02.18.11.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:28:01 -0800 (PST)
Date:   Fri, 18 Feb 2022 11:27:54 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jason Baron <jbaron@akamai.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] jump_label: refactor #ifdef of struct static_key
Message-ID: <20220218192754.hlwo6ffixybevbrt@treble>
References: <20220213165717.2354046-1-masahiroy@kernel.org>
 <20220213165717.2354046-2-masahiroy@kernel.org>
 <c65fa908-72a6-bad9-613b-fb33a6e0359c@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c65fa908-72a6-bad9-613b-fb33a6e0359c@akamai.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 02:07:26PM -0500, Jason Baron wrote:
> On 2/13/22 11:57, Masahiro Yamada wrote:
> > Move #ifdef CONFIG_JUMP_LABEL inside the struct static_key.
> > 
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> > 
> >  include/linux/jump_label.h | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> > index 6924e6837e6d..107751cc047b 100644
> > --- a/include/linux/jump_label.h
> > +++ b/include/linux/jump_label.h
> > @@ -82,10 +82,9 @@ extern bool static_key_initialized;
> >  				    "%s(): static key '%pS' used before call to jump_label_init()", \
> >  				    __func__, (key))
> >  
> > -#ifdef CONFIG_JUMP_LABEL
> > -
> >  struct static_key {
> >  	atomic_t enabled;
> > +#ifdef CONFIG_JUMP_LABEL
> >  /*
> >   * Note:
> >   *   To make anonymous unions work with old compilers, the static
> > @@ -104,13 +103,9 @@ struct static_key {
> >  		struct jump_entry *entries;
> >  		struct static_key_mod *next;
> >  	};
> > +#endif	/* CONFIG_JUMP_LABEL */
> >  };
> >  
> > -#else
> > -struct static_key {
> > -	atomic_t enabled;
> > -};
> > -#endif	/* CONFIG_JUMP_LABEL */
> >  #endif /* __ASSEMBLY__ */
> >  
> >  #ifdef CONFIG_JUMP_LABEL
> 
> 
> These two cleanups look fine to me.
> 
> Acked-by: Jason Baron <jbaron@akamai.com>>

Both look fine to me as well.  For both patches:

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

