Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8477E50A381
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389759AbiDUPBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353404AbiDUPBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 733494551B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650553081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QTpLm3aOQpkfLEJJjDuQKbkph6dKXan/c9US+6RE4vQ=;
        b=HM/gHC2t6TLK8NFf9iD8wULNZIKIDgYmjcfBKytdOa9omB+BJTOpAMTY2Qbijv3XjwCaQk
        vw0OqBkN0B8okUJyPWlebn6hm+jJMaL7F9KM9iBPsupNp7fpeWXxud2TblUnN7Km0nEFhE
        yZajq7o9+67rwx6EBP3lDkTc1w3yT2k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-teooys0kPIWEoAGWfyeHzA-1; Thu, 21 Apr 2022 10:58:00 -0400
X-MC-Unique: teooys0kPIWEoAGWfyeHzA-1
Received: by mail-wm1-f70.google.com with SMTP id 186-20020a1c02c3000000b003928cd3853aso121323wmc.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QTpLm3aOQpkfLEJJjDuQKbkph6dKXan/c9US+6RE4vQ=;
        b=zssdVYoQBjzwJSzFJN8eDwWJWcsZH1fL7L/SELuSL3eqXo+OldxrN/vJuHXhTGl955
         m3N1IOR6ZfMiQCOfMjvi+78YwXIyJ1+ScNvrvkEwNjCYzJZMvj9UpZaDy0o4Gbl0cghk
         lJbIFuQds1mCqUGI86S8vsyKNUvEF2LzOdwu4XjaBmBf+jfRk4Q8cmqMBt9PyqoztIfK
         2BdUYjSvqEcTrXSLevyzkWlOTQqGZGXCIqQ/0GX7xLg1gIZjCx4hd+z2qmsyr5VjWAmP
         dC7IptMyPV0j5Yx35/HK4693IP3POtT74c7HCqhBDDO/AEGmlvwr23jUm4Kd31Udumx6
         p0bQ==
X-Gm-Message-State: AOAM530Kybl4O1kQmv7thblOn/QoV8+tNHKcBl5gwz1N+sgRRKJsT6I3
        2JbYt4O1n9FU+tOXds3eHlD/1ykHsNko84RUexHZOtlre/aR+FG3PTKcjoSHt8C3SJ2oBPiUUTX
        YLtArgUbynZ4BsmQzNQ9TM1w=
X-Received: by 2002:a05:6000:18d0:b0:209:199b:77bd with SMTP id w16-20020a05600018d000b00209199b77bdmr79874wrq.537.1650553079258;
        Thu, 21 Apr 2022 07:57:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJ87QB6k4nsC8/Q8oHNWMq7K56KzTtSPg+WKsCl+jH76+ULd8++Qqa+PoYjSWc0h/Ay72faQ==
X-Received: by 2002:a05:6000:18d0:b0:209:199b:77bd with SMTP id w16-20020a05600018d000b00209199b77bdmr79847wrq.537.1650553079060;
        Thu, 21 Apr 2022 07:57:59 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p3-20020adfaa03000000b00207a1db96cfsm2558786wrd.71.2022.04.21.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:57:58 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:57:57 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     mcgrof@kernel.org, cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, neelx@redhat.com
Subject: Re: [PATCH v3 2/2] module: Introduce module unload taint tracking
Message-ID: <20220421145757.zfn6zxh6rx3dp75o@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220420115257.3498300-1-atomlin@redhat.com>
 <20220420115257.3498300-3-atomlin@redhat.com>
 <2100545.irdbgypaU6@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2100545.irdbgypaU6@natalenko.name>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-04-21 16:28 +0200, Oleksandr Natalenko wrote:
> Hello.

Hi Oleksandr,

> Thanks for this submission. Please see one comment inline.

Thanks for your feedback!

> > @@ -150,6 +160,41 @@ int unregister_module_notifier(struct notifier_block *nb)
> >  }
> >  EXPORT_SYMBOL(unregister_module_notifier);
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
> > +
> > +		if (len == strlen(mod->name) && !memcmp(mod_taint->name, mod->name, len) &&
> 
> Here, two strings are compared, so I'd expect to see `strncmp()` instead of `memcmp()`.

Good point. There are other examples of this throughout
kernel/module/main.c; albeit, I will use strncmp() here.


Kind regards,

-- 
Aaron Tomlin

