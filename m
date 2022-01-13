Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503CB48D4F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiAMJXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:23:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233868AbiAMJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642065789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1hPX2NhGvNI/hltjD58R6gX5RpgFP8ru9lDgC/nr++s=;
        b=DOiCo18c1hphvPEUTnnCSRsd6+U0EL7475ugQr+hc6IcjwJGWotYL852tl1Di+RuhgxMx7
        VKLDT7vpPJxwyWtkCVE8VtWaQt/cWWdUJkGQXovfnNwaVTszafDR3SN8C7kkRJU9gBbFA7
        WOm9cwwTV9HV7cu1P3Y3ER7VSge8dS4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-RqJMMLM_OWadO_M7oNUCBw-1; Thu, 13 Jan 2022 04:23:07 -0500
X-MC-Unique: RqJMMLM_OWadO_M7oNUCBw-1
Received: by mail-wr1-f71.google.com with SMTP id e4-20020adfa444000000b001a667c09a23so976078wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:23:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1hPX2NhGvNI/hltjD58R6gX5RpgFP8ru9lDgC/nr++s=;
        b=vIQ+ymiF+tMWZo88iMRCIqF1/Ajna4DKfouE8fL0aHy/CJDnxPdydNMVizjWnSfD/b
         k4oii2GbF/XHJ4t9Qd1IcTwjM2ZAEhFxqmVzhRAk8NzazAtBpjJqKZBuMSgLf8ZNuLFo
         fnT+Ydnin+JN8uMPbWU+X53glSGxMoZICFtBz+jXkMuyaqvF7AGq5QONhztx8uGb9eXW
         GZdufa/4ipcD37K/3sBjsfQpGw/rrwvaXkECpYTkMEpNu/nUUbETKk1cyd+SSbONeLxc
         cnLCj57tgJtT8mJmYaZPGQZJYnVGwZ8ASN43kGuIOIM5thllZ4n2e3YT2gVL11Qq7chx
         8+xw==
X-Gm-Message-State: AOAM532ARTB35pY9F7yfsnLPukUt+j1n1CbW8kv/zC7VQhhDuLdXtxlW
        UqrcwF1GK6lf9UhXi5tQCdIWPt/S/p4VHVWQ+t+ARIukzxW25xEW0CGk7ImzqWYYg0fCoeyDJbp
        gznSjwEWZ68dEoCPWtAKiCi8=
X-Received: by 2002:a1c:f616:: with SMTP id w22mr2937443wmc.75.1642065786704;
        Thu, 13 Jan 2022 01:23:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpYM5wf8R2hHTozXrisz5AtIoPofliMJ4qxbH+yf3kHAG+gYnDOXLO2pwW5bFiIBUseKX59w==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr2937429wmc.75.1642065786481;
        Thu, 13 Jan 2022 01:23:06 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id j11sm2690364wmq.23.2022.01.13.01.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:23:05 -0800 (PST)
Date:   Thu, 13 Jan 2022 09:23:05 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Allen <allen.lkml@gmail.com>, Christoph Lameter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com
Subject: Re: [RFC PATCH v2 00/13] module: core code clean up
Message-ID: <20220113092305.vx3kexfqhplxirmh@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220106234319.2067842-1-atomlin@redhat.com>
 <CAOMdWSJHm9bRAcrB6U+FsRiK6Fg2bbtbUH82w54VD7kbFmnVsA@mail.gmail.com>
 <CAOMdWS+Sn1sZJt8ocig5U7d7qG3N8oJBW-D1ey0qbZ3AXF-JWg@mail.gmail.com>
 <20220112132104.7emyelwuv3jmmhdt@ava.usersys.com>
 <Yd75OzrhrjDp7CVa@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yd75OzrhrjDp7CVa@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-01-12 07:52 -0800, Luis Chamberlain wrote:
> On Wed, Jan 12, 2022 at 01:21:04PM +0000, Aaron Tomlin wrote:
> Please work off of modules-next tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next
> 
> That is, this tree on the modules-next branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git

Understood.


Kind regards,

-- 
Aaron Tomlin

