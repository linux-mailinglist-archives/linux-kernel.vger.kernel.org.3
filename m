Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28245645D3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 10:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiGCIdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 04:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiGCIdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 04:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 203069FF3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 01:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656837211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L2agBExMK3C9mHR+WZLQeszR+IgajYWASmVgSqI4ZbE=;
        b=cKU83xkliJHaQnxlbs2Fn/UqWLcB1ixO/lajbF+W3H1OjVdYk+0FfTMTIoyGPHGMWzTnXF
        cGc1PImtvzzLNG0OY6l+065+drH6sAmIAQGYLVwBRMz3E9Z8xE92Lc8E9A8/bIOzoblGOn
        oYg/7tczGOpiSHv3q/cFeKESeSULay0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-7gE6n-mcOhaOU6OTvgE16Q-1; Sun, 03 Jul 2022 04:33:27 -0400
X-MC-Unique: 7gE6n-mcOhaOU6OTvgE16Q-1
Received: by mail-wm1-f69.google.com with SMTP id be8-20020a05600c1e8800b003a069fe18ffso5649646wmb.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 01:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L2agBExMK3C9mHR+WZLQeszR+IgajYWASmVgSqI4ZbE=;
        b=Jm3kKjNBtlwriFC+IY27zGU7bqTDKkIN5HofE+vPpM/wxbEpCW2AY4Gtjmi2w+82Wc
         NBYFm+D1bCDGCfmhROQim1kSBuJ7Gv1RmfngTXlEWBsJrAj7Zt3A3Fl626j1SuUs569D
         AixI51yXr1Vjl7G6ac/4sD28zJ3KX5j2qlzi9Pe3TdRqBZSq9B4JLiJNx9bo1lWauvxK
         cV+C4fR3pkwCujjj4TdjqSKyogyvl5Yae5RvUavuznb59lpqjt6DUZKh5BGBMxPJOFtp
         9vZfUg2npiaI8gMWyKzm6vT3jTdyIb/y/xsMTzoorFaXCH1/P9d/KCXpWeDrkA0iP0ef
         XasQ==
X-Gm-Message-State: AJIora9r0Rp0d8L6T/3s2Uq6v4j+amVlo6XevrwhR6OGVjra/COqF8mM
        ic8p9OpA5pXACeSCx4gwi4vTzxvOiUIjk74Vvnr60UK3fnIjcyCS57MIzwUw+NEjk+l9HwJvSmF
        2sK34zqO7bVaB4+M64NhaEzQ=
X-Received: by 2002:a05:600c:4fd1:b0:3a0:5416:2fd0 with SMTP id o17-20020a05600c4fd100b003a054162fd0mr27386777wmq.197.1656837206601;
        Sun, 03 Jul 2022 01:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vI3d41GGsw6gayBQ1WEUA7lNU7AEm1R98SC0VYyiRBeJhUyUK8LvB+hE9pZUWPGMxmPmydZw==
X-Received: by 2002:a05:600c:4fd1:b0:3a0:5416:2fd0 with SMTP id o17-20020a05600c4fd100b003a054162fd0mr27386740wmq.197.1656837206324;
        Sun, 03 Jul 2022 01:33:26 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b0020d07d90b71sm26485519wrp.66.2022.07.03.01.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 01:33:25 -0700 (PDT)
Date:   Sun, 3 Jul 2022 09:33:24 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, christophe.leroy@csgroup.eu,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 09/14] module: Move kallsyms support into a separate
 file
Message-ID: <20220703083324.az24ou7nrngvp73v@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102413.3438665-10-atomlin@redhat.com>
 <20220628000526.11c57cd8@gandalf.local.home>
 <20220628081906.jln2ombfej5473xi@ava.usersys.com>
 <Yr92YtG12f+II+ea@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yr92YtG12f+II+ea@bombadil.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-07-01 15:34 -0700, Luis Chamberlain wrote:
> Poke, did you get to implement this yet?

Hi Luis, Steve,

Firstly, apologies for the delay.

I believe I found the issue:

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 1b0780e20aab..84808706af5c 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -197,7 +197,7 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
                            mod->kallsyms->typetab[i];
                        dst[ndst] = src[i];
                        dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
-                       s += strscpy(s, &mod->kallsyms->strtab[src[i].st_name],
+                       s += strlcpy(s, &mod->kallsyms->strtab[src[i].st_name],
                                     KSYM_NAME_LEN) + 1;
                }
        }

That being said, I need to examine the precise differences between each
implementation; albeit, I believe we can revert this particular change. I
will send a patch for a wider discussion shortly.

 - Before

      $ grep -a -E '^[0-9a-f]{16} [^a-z].*\[virtio_console\]' /proc/kallsyms
      0000000000000000  notifier_del_vio      [virtio_console]
      0000000000000000  show_port_name        [virtio_console]
      0000000000000000  port_debugfs_open     [virtio_console]

 - After the above modification

      $ grep -a -E '^[0-9a-f]{16} [^a-z].*\[virtio_console\]' /proc/kallsyms
      $ grep -a -m 3 -E '^[0-9a-f]{16} [a-z].*\[virtio_console\]' /proc/kallsyms
      0000000000000000 t notifier_del_vio     [virtio_console]
      0000000000000000 t show_port_name       [virtio_console]
      0000000000000000 t port_debugfs_open    [virtio_console]


Kind regards,

-- 
Aaron Tomlin

