Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C784546E762
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbhLILT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236469AbhLILT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:19:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03C4C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 03:16:23 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q3so9074871wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 03:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8AS2+fjKTCdK/tugD/kZ9IGEKX/TtBYXDsW8ZkOfDyg=;
        b=x6rXfAfjFtrkIF+z7JJTXZmxjIaepniVgtEU7LC9PP8nRcL1Lbk9QPVuWWOqpjnwWL
         59pkV3rQnoKYPV6Mj6AtWpkYcOqlwjI+AfluBUUAOgR0Y69a5btfStVj0XYnPPd/9moV
         VAKEXHAL56W3VnPW53nGiT+RQHog0zOLvb2pcwo0EtV3aIYJVOhZtyKs/w9BlZXXDP/B
         n2Q0nyEMNTCVt/ukL0I7P04WPS+u2+z08GVj14ULrfUGq7wTaNQvtv+aDEN7Tki2E2w4
         oSIOQus7l63MybcJYvjIT/2p1N79pd9qBqdHspP2TzoW+0virTLt5w9C4TqQ+gEshV2E
         7riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8AS2+fjKTCdK/tugD/kZ9IGEKX/TtBYXDsW8ZkOfDyg=;
        b=rA0OgSInmMj3sTxh8P1vFgifjIanNjecGouuq17DqwxWvMljTBirU3diRuXhTXFAc5
         AM8FDcZIuotP5U9FQf8Tx5rCZPBlXosJ32YJ/la7M7tkIPu1R0Qc9lG8rInCyRtmIYk1
         VtFnFChaVR3j5jO1adwg6fku2PFdrgrLRn6BRJ6+H8jdFa9LxlJMdnhW0OsL4VB1TGj5
         IcgcuPPZe8yfv9hrN8zSdgr5T+0AJ61YyPZEIcQN4GSf4H0cvQGvDob1nfjhcxNZ/BsJ
         3dxM0JvvbIxOSdosl/27Ln5sZ+7/6Tp6Tgup70CWsmoXLNr8mP0BgfD6L4ww4tUpfhGt
         fW0Q==
X-Gm-Message-State: AOAM531ZF3YEnHY696HJ1nNDvQkZtXeAfdWo/vMSjV9UPhuJ9fHYQaZI
        Ds3aghXMVRb61h7eLLeauP73xg==
X-Google-Smtp-Source: ABdhPJyKYDOGxA6gESzkGn6KuNPY64wNqQOflplK4/lamEoWYnS+Kt6okDeHVbs8ynuyDRz0wvieAQ==
X-Received: by 2002:a05:6000:547:: with SMTP id b7mr5616505wrf.543.1639048582498;
        Thu, 09 Dec 2021 03:16:22 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id p19sm6032208wmq.4.2021.12.09.03.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 03:16:22 -0800 (PST)
Date:   Thu, 9 Dec 2021 12:16:21 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Shay Drory <shayd@nvidia.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, jiri@nvidia.com,
        saeedm@nvidia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next v4 2/7] devlink: Add new "io_eq_size" generic
 device param
Message-ID: <YbHlhd0sFDwF5b6g@nanopsycho>
References: <20211209100929.28115-1-shayd@nvidia.com>
 <20211209100929.28115-3-shayd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209100929.28115-3-shayd@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Dec 09, 2021 at 11:09:24AM CET, shayd@nvidia.com wrote:
>Add new device generic parameter to determine the size of the
>I/O completion EQs.
>
>For example, to reduce I/O EQ size to 64, execute:
>$ devlink dev param set pci/0000:06:00.0 \
>              name io_eq_size value 64 cmode driverinit
>$ devlink dev reload pci/0000:06:00.0
>
>Signed-off-by: Shay Drory <shayd@nvidia.com>
>Reviewed-by: Moshe Shemesh <moshe@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
