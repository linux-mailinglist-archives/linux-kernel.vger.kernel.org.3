Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F36481125
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbhL2I7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:59:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239391AbhL2I7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640768341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZWOEN7VG4jXIP35MPsYStOELlrvFsfJHsjcJKLQOyCo=;
        b=IDQDwbNBil3XehjChL2mnSr93nkH9aDvnKYiOeZ5WctFzaHuYTkYJWyJQuk5y0Hh/u9CKK
        gjqqZoUPnJqZBtx1ItPy2qKx3/79yqmf9hU70jLu3zpA5RYVHBBpNBDJ9bNrdrRNahiFlh
        u+4Qar1AquJvQZTnitI4b5RcKWLcbnY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-E36ApR3gNvCHCvxKBKRUjg-1; Wed, 29 Dec 2021 03:59:00 -0500
X-MC-Unique: E36ApR3gNvCHCvxKBKRUjg-1
Received: by mail-wm1-f69.google.com with SMTP id p22-20020a05600c1d9600b00345a25ea8cfso5820762wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 00:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZWOEN7VG4jXIP35MPsYStOELlrvFsfJHsjcJKLQOyCo=;
        b=RZ1v+aARZST5qbbd8qjJGPYM/L/yAjYJy6yC0exQGyDIdJvRmLUTH82K2Vnz0iKRvo
         rYJoDfOrkM2OjOVqnmWrUdmzfAxVOdmDYT4hUi21D5kglhr8D4WIJ57Ia2L8WNlKTkLS
         DHeRJ/HI91LTpJRsQBZitXWDnbH61k47O3ns1icy5TLU4zpgwLLVnA3ARjbeil54EPVN
         Dhc2QbaP+hY92X5XU/jUZlZjRzpgr/kzyvGz2lLitJiZnKa/XOJbn4Ja/LTcGEVCkwFs
         i5+dwRZsmBbL42Afn17pA/0C5youT0DrEVhUiHkjHlM+3yZX68XMseQX5qqu2uzylUgQ
         EmJA==
X-Gm-Message-State: AOAM533R+f3QaKZ7oAyidKO6Rc3APuCDflw8daG5biqrSzHx/q2Pc5E1
        fQi7ReG4vQKETIeQ4xSMvcmSJH4rxChr3ChVo9IbfJvd5DM9/4GCnfXj6lnzwac2CV7jzXEjgdp
        Se7Yof66qA+UrFb3jJSrK4O8=
X-Received: by 2002:adf:82f6:: with SMTP id 109mr19696837wrc.169.1640768338975;
        Wed, 29 Dec 2021 00:58:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygLKaNE7oOH8dIDgyOilc8TLTN9ihP1j9sD0P+FRkcvWryxJUcXkZvCs8HHUxQV1JmZtowBA==
X-Received: by 2002:adf:82f6:: with SMTP id 109mr19696830wrc.169.1640768338827;
        Wed, 29 Dec 2021 00:58:58 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f6sm20620425wri.115.2021.12.29.00.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 00:58:58 -0800 (PST)
Date:   Wed, 29 Dec 2021 08:58:57 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, allen.lkml@gmail.com
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: Re: [RFC PATCH 00/12] module: core code clean up
Message-ID: <20211229085857.jj7exfjqzevuclcp@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <20211228213041.1356334-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211228213041.1356334-1-atomlin@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-12-28 21:30 +0000, Aaron Tomlin wrote:
> Hi Luis, Allen,

Adding Allen.

-- 
Aaron Tomlin

