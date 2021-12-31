Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1076482215
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 06:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhLaFKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 00:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhLaFKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 00:10:46 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C637C061574;
        Thu, 30 Dec 2021 21:10:46 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so7555337pji.3;
        Thu, 30 Dec 2021 21:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e0YefREn4gELMGJZJ+pkh6rFK9yjum+kekppiSmQYkk=;
        b=FSnV/pMiUeqAg14q11imoCyrwOAdR0DDRrEVOpCWGv0+Q5Gtavh7LpUDB1rsCE+zfS
         z16YXRC6GAnrmxqHZBF9gWreOxpAFyaNNfkJ5E41N4k3BB+xjwKNBzFuIOA2mcZ2hTfe
         44GME3G5WrF5PGXL0qb732Ze9fCt7oT9XL4ic1Q06OyOm/ZFDtnEv4cUM72Bbg/EBasK
         7LHZ98sbVJvnGkubUgog4cNHTVWNSy/AJLGaRp5kG+ixPJWLJsNYOJR7quTcskprKaDP
         pAx5OkoJNXl3Eee0GeHGNxRTNQW4xGkWp9Kwu2EMYWunO2VsWOT2pYYR8wZe+ryb7ffE
         KXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e0YefREn4gELMGJZJ+pkh6rFK9yjum+kekppiSmQYkk=;
        b=wMbdv94AImhQaAvuLCzUb7xbobQXNX+agz+pqLakyquEgTS8XrMczcezNsW5svhGPk
         0BBAeGvv3D1yFebwTLLfQxLewb7gH386DsmzprOoH3L8hH3jljsejfERqzVKjST3gYCb
         VZdveP+ZRGtQ/QacNpvvYgaZfr8FXVK4nD9wFUw/tgISV7O+BZVcES+r7bGQe/MJW0so
         pQNhZnx9afLb5iQ58ZhgQmazghRQnHqOn4h51fNZ8k3xKjtHDPVYAvSxDih2LUJX8OQ3
         flB/ldzyA7rJij9SV13YUL2W6wEUkcOSOSjx3fv50PS8D3ljtO6JdnJeUtk/AZq0ihtQ
         WIJg==
X-Gm-Message-State: AOAM533/pmlW8zuSXvQ5yUMpcd/W2/cRLJPe/6GKYOkSichiVbT22UD2
        ngoEOk1R+5X13G9t4HO4aoxqYwtE65c=
X-Google-Smtp-Source: ABdhPJybFD+6RW3rZV6Lxx2VEorevHsCNtXLiUCU2yrrfZF1WCUPFSKoiA3l/brIykmBuUZMh9nMTA==
X-Received: by 2002:a17:90a:1919:: with SMTP id 25mr29757112pjg.181.1640927445433;
        Thu, 30 Dec 2021 21:10:45 -0800 (PST)
Received: from google.com ([2620:15c:202:201:ecb6:a6a9:17cc:2829])
        by smtp.gmail.com with ESMTPSA id z2sm29877144pfh.188.2021.12.30.21.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 21:10:44 -0800 (PST)
Date:   Thu, 30 Dec 2021 21:10:42 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Leo L. Schwab" <ewhac@ewhac.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: spaceball - fix parsing of movement data
 packets
Message-ID: <Yc6Q0tqQzHcFdlyU@google.com>
References: <20211221101630.1146385-1-ewhac@ewhac.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221101630.1146385-1-ewhac@ewhac.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 02:16:31AM -0800, Leo L. Schwab wrote:
> The spaceball.c module was not properly parsing the movement reports
> coming from the device.  The code read axis data as signed 16-bit
> little-endian values starting at offset 2.
> 
> In fact, axis data in Spaceball movement reports are signed 16-bit
> big-endian values starting at offset 3.  This was determined first by
> visually inspecting the data packets, and later verified by consulting:
> http://spacemice.org/pdf/SpaceBall_2003-3003_Protocol.pdf
> 
> If this ever worked properly, it was in the time before Git...
> 
> Signed-off-by: Leo L. Schwab <ewhac@ewhac.org>

Applied, thank you.

-- 
Dmitry
