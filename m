Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192B246FA18
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 06:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhLJFX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 00:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhLJFXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 00:23:25 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71846C061746;
        Thu,  9 Dec 2021 21:19:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so6592837pjb.5;
        Thu, 09 Dec 2021 21:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w4eB1WBggo/oaafdzywqGy6NQmIvYM0/Td6oIEwf71s=;
        b=pKyrojy2EgaNWfEvK9tE4zuG9V5m+nlDfigfZLX54oVKgevxtebmueG0W+CAvpA4no
         9t3yoFGZ0RHAoSZM0P9Z85wBveLzR9DUKDoHwCRHqECphSNhpwTT1/ClM/nZDbhyDKBl
         Fpyyg0r9L3DtQaN1fizI0kfLWJ6FiauaCtbk5tvlP+Xn7e04k+hgNmJQh5iVaBWucIsv
         Ste2KRYsD7Hz2I8q67ZglFYnPT0tWTLdi3oOnsQmy9MvfhYVV9H/yhGW30svLMaldNJG
         DyYUClpFs5luk/enGtgFdygQuw1i2rzu8c7rsNNpBmdHVEPzWvOjwWQ/DvzEmjaaKpKk
         WDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w4eB1WBggo/oaafdzywqGy6NQmIvYM0/Td6oIEwf71s=;
        b=d8ACI0GJgzv/Ab540hVkO7sX253/F29jlC7N2E2CawoNONYr4dD6QJlt8QtsQ0EwxA
         9Gpo4f/bAT9lWQkI1TaXjJ/3y+YCU9MXDM7NAyf9AHSTK50uL7eA1p72ClEUtoqHQfgX
         TyCyUxY6muN5LnrS2sjRJ0K333XihmG5iaDsLBgHQMKvxPdIYGdzTlAXveCCgwdsLTqi
         T9s5EL8tQpMufEDjQBXCvs/WhlLHcuGT9+ApGsTAt2T0XiAIIVkqFFxpQ4QU0Pi1Yq4B
         TdeteqJ0kAFkq1dmgQbxNMRqJUHYH/vsrrTUa5W/bMWAWjg0bymIM+9TEFHyUApu46YA
         QXDA==
X-Gm-Message-State: AOAM5329NK/NbZE2W2dWEr4SEywSS/tuRC9N3KS+nbYAXvq56f1nWLtD
        ty/3zuvMSP7rsB7/yF/iY0gdwpzT76w=
X-Google-Smtp-Source: ABdhPJxVbpENBYHo7w7HohceKdVP/SSVK5nUlB+BNu90OgD2OTFaq804s4n3jxoEN/Nm6nnOs6pHkQ==
X-Received: by 2002:a17:90a:1919:: with SMTP id 25mr21674910pjg.154.1639113590882;
        Thu, 09 Dec 2021 21:19:50 -0800 (PST)
Received: from google.com ([2620:15c:202:201:8a3d:b2f2:42a0:335a])
        by smtp.gmail.com with ESMTPSA id q8sm1477215pfk.152.2021.12.09.21.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 21:19:49 -0800 (PST)
Date:   Thu, 9 Dec 2021 21:19:46 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     hdegoede@redhat.com, hadess@hadess.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: goodix - Fix memory leak in goodix_firmware_upload
Message-ID: <YbLjcm6tJnqbVfpi@google.com>
References: <20211208173321.26659-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211208173321.26659-1-jose.exposito89@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 06:33:21PM +0100, José Expósito wrote:
> Addresses-Coverity-ID: 1493934 ("Resource leak")
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Applied, thank you.

-- 
Dmitry
