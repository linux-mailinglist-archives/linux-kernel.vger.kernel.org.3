Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D67E4AE884
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiBIEOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347222AbiBIDjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:39:21 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F19C043180
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:32:11 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i186so2082965pfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 19:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U3YWRJiOX6r2DiP9iWkoebtSk7wb9LQgDyPaYKJpHzg=;
        b=nXjf/f5LQhRawIBVlV+uE2HRNSdBDqb1TVkY42Ucyl1AFQmJYizT78Mo0V0i+FRlJX
         rkXkKyZSaZlcW4b7o4vnjdFAzIGsQGWZtTQ7/n2MDm3LOZgspH4jaup9YKX7Wx3zDbR3
         juZ78ajOOZPzoQDNqX6MLmJvQWkpMBlyfbem9XPtvyItr240K06KEWR9y9RDRFM9UwDD
         /e8srRI7OVqLv/UhiVxWE+OcLqZ8CcEnoPei08wnD8RIWMa3AOL1Zqhoer3LI2XKwnZL
         AAYXEaEfFaasSmXgNlKy3+Lj+QEo70qkWiARvzdtca4LrlUlK247CO0X+6C1oTXh2ih3
         Qa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U3YWRJiOX6r2DiP9iWkoebtSk7wb9LQgDyPaYKJpHzg=;
        b=eNdjHCFUwzRG6dPnDEkCUWQrJyjaEJ5yS55cRcgdS78ixuD7881AQqERh/YUVkSpwR
         9zFKq6xK0nPN7KFeKAXzhJaRfWByFwwFm2lA15Fql3DwMQ174MSCYNbkWiCtu6Eo7Sq6
         roIadbwbOkJLDbbang6QbDqdPTFcBQ1fUVZF20yZs2znetDFSlErDukNy4wORgA2UMgZ
         GOjtuHWH4rzExeVx7wix4P55BqLaVJFKm3W2vOZuMthZc9uv5G8aoNdApwbda2D/NaG+
         aVLK3jsGBMhxloSB07k91bpRPoAtPjOFvKH1rYSI0cqj6RmuuIJOmh1EMoBomqUHLKAj
         LEIA==
X-Gm-Message-State: AOAM531GLFZEmvYEXUHc0UzNe80DM3xoSep/ZIi7gaDYnRCtmFeMegEe
        Q8766GXBuiWe70b8brMJgm1SQA==
X-Google-Smtp-Source: ABdhPJy7m6DpHFgJiKhMcyEac2ifKifQfKmXJnjw5v0c9O67wVpVHjnzSDcZixIVJaVAmGOKe1cPxw==
X-Received: by 2002:a63:2c92:: with SMTP id s140mr372406pgs.448.1644377530580;
        Tue, 08 Feb 2022 19:32:10 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:4b6f:f14d:be50:86a])
        by smtp.gmail.com with ESMTPSA id y15sm17012526pfi.87.2022.02.08.19.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:32:10 -0800 (PST)
Date:   Wed, 9 Feb 2022 11:32:07 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 1/4] platform/chrome: cros_ec_typec: Move mux flag
 checks
Message-ID: <YgM1t3aJPwMbhEQt@google.com>
References: <20220208184721.1697194-1-pmalani@chromium.org>
 <20220208184721.1697194-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208184721.1697194-2-pmalani@chromium.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 06:47:18PM +0000, Prashant Malani wrote:
> Move mux and role flag checks inside of cros_typec_configure_mux(),
> which is a more logical location for them.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
