Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1665176C6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356287AbiEBStO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387018AbiEBStF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE7E8B7CA
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651517135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YnpbZs50SiOUxfAVjbV2pZV2prkPBtBeiEirw1AUs2U=;
        b=GcYRAQuMd7R5PUji1Fd4P7AmBzSZVEtNz2fXHV0i/K6QSB2t+tsOsa03ot4QSCKnmxxwzv
        l/WT4fbXSQoolF1lhBdqeUyNnYkzGM7KnxrAm++9uiUmYaobjmZxgfcuIPU+L89BXMe7Go
        k4bktLUhAt2zMcZ9hAeI/gw+FH9sxAg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-nj22mpb1NO6Gfw_0Sqr2BQ-1; Mon, 02 May 2022 14:45:33 -0400
X-MC-Unique: nj22mpb1NO6Gfw_0Sqr2BQ-1
Received: by mail-wr1-f71.google.com with SMTP id g7-20020adfbc87000000b0020ac76d254bso5592367wrh.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YnpbZs50SiOUxfAVjbV2pZV2prkPBtBeiEirw1AUs2U=;
        b=dFG6n5mc7GEJEWx/KvadE9QVORbeTWLqKwnSLmAGzG9RYS+X6BMGFr945w8aG1WdRP
         VCcB7SZDhN8g5hTFjhvj5N43VCp/rdUcGo5Gepbp+8cKGPClVrO1bz8pKrWocv4yePQ3
         12zK7dWcrFTSjq8o2BI+OBtLKFMeI3aljhCYEtIaP61f+xc1yt0ldxrsVpKp64FlxpaI
         UglmUpeX3l7XjQecaN+Mdm5bioO+1p1+RGwdsnY3h/TNKM5jfxxzEhf8UlHIS6UkQCp7
         cXF8aM4fvHFpx6zRtaIeUBKsKWkrUY9BBdTXVm8///dwBh6dRnlmi/fLcDQaq4TL2a9U
         YanQ==
X-Gm-Message-State: AOAM531wZvFaT5DO2q3bkvhX6wBxC6ZTUAVM8UssIasoMejC8vseOhNF
        lorExl1Zxmz1PNiztqrOj+WmDmHnJoXjicnGDjV7Ap3IxO7pn/iPOn/FYML5a1/RRNBxscKruOB
        8ejqpge3Mk+e8FdsU0C9poAQ=
X-Received: by 2002:adf:de04:0:b0:20a:da05:39b with SMTP id b4-20020adfde04000000b0020ada05039bmr10116696wrm.550.1651517132776;
        Mon, 02 May 2022 11:45:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0CRrYsZbpYaf26cjkrGdBToN8jh082LL+RimY903CNaZts3xfryiuVWt6qLIKcs5La+OBdw==
X-Received: by 2002:adf:de04:0:b0:20a:da05:39b with SMTP id b4-20020adfde04000000b0020ada05039bmr10116681wrm.550.1651517132544;
        Mon, 02 May 2022 11:45:32 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l12-20020adfbd8c000000b0020c5253d8edsm7822588wrh.57.2022.05.02.11.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:45:31 -0700 (PDT)
Date:   Mon, 2 May 2022 19:45:30 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "neelx@redhat.com" <neelx@redhat.com>
Subject: Re: [PATCH v4 2/2] module: Introduce module unload taint tracking
Message-ID: <20220502184530.qjbl7rkilmxtmsgg@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220425090841.3958494-1-atomlin@redhat.com>
 <20220425090841.3958494-3-atomlin@redhat.com>
 <73869e4f-7190-221c-897b-fc13ec54c8cb@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73869e4f-7190-221c-897b-fc13ec54c8cb@csgroup.eu>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-05-02 11:07 +0000, Christophe Leroy wrote:
> > @@ -150,6 +160,41 @@ int unregister_module_notifier(struct notifier_block *nb)
> >   }
> >   EXPORT_SYMBOL(unregister_module_notifier);
> >   
> > +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> > +static int try_add_tainted_module(struct module *mod)
> > +{
> > +	struct mod_unload_taint *mod_taint;
> > +
> > +	module_assert_mutex_or_preempt();
> > +
> > +	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
> > +				lockdep_is_held(&module_mutex)) {
> > +		size_t len = strlen(mod_taint->name);
> 
> Why do you need that strlen() at all, can't you just use strcmp() ?
> With strncmp() what happens if for instance mod_taint->name is "dead" 
> and mod->name is "deadbeef" ?

Hi Christophe,

Thanks for your feedback.

I see that. Furthermore, the length of a module's name is fixed.
Hence strcmp() should be fine.


Kind regards,

-- 
Aaron Tomlin

