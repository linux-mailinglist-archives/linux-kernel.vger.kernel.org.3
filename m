Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D342356592E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiGDPC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiGDPCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0303E6368
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656946974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbPVFg5HfSLExs8n8PnCNX+mcFJDkOgFSN/8HExwOpA=;
        b=W6jiU6gTMCXKcmBER4CK2Bd6NVm6+GG6ZsHmpbcVZDh7hlnw6X4xo7LwKZOfLCC/X6ABq7
        h9MsVnlVUpGFAOLClk7z3qSISIJxRyuVrxXyQ/NcPGzDR4YWhbJnV1CZ+6ER96vlAk64q3
        x7852aTUplUwzrT4PUHkATXbPvJ4fk4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-LaUrDOIwPeKNeOoav0URaQ-1; Mon, 04 Jul 2022 11:02:53 -0400
X-MC-Unique: LaUrDOIwPeKNeOoav0URaQ-1
Received: by mail-wm1-f70.google.com with SMTP id c187-20020a1c35c4000000b003a19b3b9e6cso2587526wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cbPVFg5HfSLExs8n8PnCNX+mcFJDkOgFSN/8HExwOpA=;
        b=YJy+iYUU9mzQaeqKyPzGc6W/pyfaAn18diTpgXewRPw1l8uXtc+VQ7n7+7dFyQOIYu
         BZTbzV1uJOXAmVUIbb2PkShY7+uIGBSNNVHjh0y1LwyriqKu0NObWAzP7VTeuHpLzvPX
         RCETMk7zEiAJvwPeaABvM7TY5ElILxXPYLCcst9h1l3n3eMcVqGhchQhR46hZml7T2mb
         PnnhiRVjsVqr81vAfunhPgjTDeoDPEx6JO3knPho1YjUOjtEfqvl18T0E+tgTt/N95PH
         L13KUDIeXh7khU7lx7H948UnwqcTfbAuYaR2un4LnOzhnC8Je+OBET8PsWaXsNu4YfV6
         rypw==
X-Gm-Message-State: AJIora8E+W717b7O9XV/tBVJrTMku2KK10/JTllNjmNJRnLy1fJlLdlg
        oO0SK8WhXaWgzqXJ+GCZ/vzNaMSYwY7GAn+OVoHGOReq2V2Rf3xR6B3IwVGLiPxBQYAtQrklIgH
        IwrjWj5oCC7FpO2Yy3EAg7ng=
X-Received: by 2002:adf:e702:0:b0:21d:6900:ea1c with SMTP id c2-20020adfe702000000b0021d6900ea1cmr6477178wrm.620.1656946971482;
        Mon, 04 Jul 2022 08:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sPzYr8Iuz4JWFuy/bxMQLAhayVyp/s0V3e6xRbpAesBg1i9PcXXW7Pw7n7srJq66M4b08TZw==
X-Received: by 2002:adf:e702:0:b0:21d:6900:ea1c with SMTP id c2-20020adfe702000000b0021d6900ea1cmr6477151wrm.620.1656946971326;
        Mon, 04 Jul 2022 08:02:51 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003a04b0bcb43sm19451631wmi.40.2022.07.04.08.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:02:50 -0700 (PDT)
Date:   Mon, 4 Jul 2022 16:02:49 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Christopher Lamenter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, oleksandr@natalenko.name, neelx@redhat.com,
        daniel.thompson@linaro.org, Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] module: kallsyms: Ensure preemption in add_kallsyms()
 with PREEMPT_RT
Message-ID: <20220704150249.rwxekvj7nlarja6b@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220703123109.3770204-1-atomlin@redhat.com>
 <CAB=NE6VYhoXbS2TYN_+TP1P+C5kbnNBNr2vr8V9Fs2dvm6NL5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB=NE6VYhoXbS2TYN_+TP1P+C5kbnNBNr2vr8V9Fs2dvm6NL5g@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-07-04 07:55 -0700, Luis Chamberlain wrote:
> Aaron, thanks for the patch! Your commit log however reads like an
> optimization but it's a fix that needs to go to Linus, as such, can you
> update it to explain clearly *why* it's a fix.

Hi Luis,

Sure - will do.


Kind regards,

-- 
Aaron Tomlin

