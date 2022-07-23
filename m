Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B9A57F025
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbiGWPoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 11:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGWPoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 11:44:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6751EEC0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 08:44:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id os14so13321888ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vzbWWqxYeYmLDBePzGJZG4u77RbNrENkiUPgbd2i+ek=;
        b=C76uGIWVZX1OHxEG4XznyoLri0sHiDUk31pJHae/yAP2qUBtoyvVFJ6AiqWk5xwsf4
         xpuzkyKMKqio802O4NGA24Yz1Z9ZmWxQ/Jb2tRRJOPlSdMmkynMaKh2sMWncAaTpe9Mv
         4ln/lZH/BwkjqkDboNJcpl8unxEuILWMvUZtSNGZ5lFGzoGsfG0R1JyfAynoKdqpp3Mc
         qdRNNcy3WCit/52vpRbDEU/McVzTaCZ2oKCP7po2TBt92wH+6wjQWvfSRLf0SZCPa0Pz
         2WmsHD1KZWBoqHqjwJzUwiyWK/hsGn+g0LQjTTw1a6UEveNxcGxiBa19x7SivDPVLs4C
         Ro9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vzbWWqxYeYmLDBePzGJZG4u77RbNrENkiUPgbd2i+ek=;
        b=jk7cgEx2pnj6F/0fre7xydIlOKJCcIneABvkPxUcJXppLJPxX/5f0U1iTA1WcexmgC
         RBAnoVR/ZJAwzRDULGLqjCtQ3jO0TUojghVG+TdiZYAJTSz+x0RC39bN0r7Q95TdbnKk
         7L+j+pFcuW1q1OhYkKbdaafi8b5Q03dCOYpFSd8CEzpN9/qGCZu38XERV3kkQ7gmEXNb
         XJzsnby7yGmZghvpO9QG1wY40GUfPRzTbd4zmBg48HbhqcYeKgqQLvk6tOUcrgtKxL0U
         uRsCPESplpY5m+IFp08gKjbFpvK0eSXPCZ/KQ8o0JPrX0jm1/d+IOZz4uGUiQ/BdFpvt
         CDog==
X-Gm-Message-State: AJIora+J4uBUOX4Ychc5/Is5LKo99GdjN3ZBPVyifxzTosk99C1Ebhiw
        xwg4QQCiozGwqdEGEKeZqVOCRA==
X-Google-Smtp-Source: AGRyM1vlA9IvYPgdQRXjnokImcQLgvSSbSzQxehA3bchGJ58rbFWaNZECNVjDmku9kf5pVwoBj17qg==
X-Received: by 2002:a17:907:7b87:b0:72e:d45a:17af with SMTP id ne7-20020a1709077b8700b0072ed45a17afmr3833010ejc.73.1658591039932;
        Sat, 23 Jul 2022 08:43:59 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i12-20020a170906090c00b0072af56103casm3214985ejd.220.2022.07.23.08.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 08:43:59 -0700 (PDT)
Date:   Sat, 23 Jul 2022 17:43:58 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vikas Gupta <vikas.gupta@broadcom.com>
Cc:     jiri@nvidia.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        dsahern@kernel.org, stephen@networkplumber.org,
        edumazet@google.com, pabeni@redhat.com, ast@kernel.org,
        leon@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
        michael.chan@broadcom.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v6 1/2] devlink: introduce framework for
 selftests
Message-ID: <YtwXPt1VzGQr/6Bg@nanopsycho>
References: <20220723042206.8104-1-vikas.gupta@broadcom.com>
 <20220723042206.8104-2-vikas.gupta@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723042206.8104-2-vikas.gupta@broadcom.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Jul 23, 2022 at 06:22:05AM CEST, vikas.gupta@broadcom.com wrote:
>Add a framework for running selftests.
>Framework exposes devlink commands and test suite(s) to the user
>to execute and query the supported tests by the driver.
>
>Below are new entries in devlink_nl_ops
>devlink_nl_cmd_selftests_show_doit/dumpit: To query the supported
>selftests by the drivers.
>devlink_nl_cmd_selftests_run: To execute selftests. Users can
>provide a test mask for executing group tests or standalone tests.
>
>Documentation/networking/devlink/ path is already part of MAINTAINERS &
>the new files come under this path. Hence no update needed to the
>MAINTAINERS
>
>Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
>Reviewed-by: Michael Chan <michael.chan@broadcom.com>
>Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
