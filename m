Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAADD543BC5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiFHSxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiFHSxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:53:01 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC45A192C7E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:52:59 -0700 (PDT)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BE41D3F207
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1654714378;
        bh=1xC7xuJX2LwCqZhAFi0xIy8j41xevuej7OLQ+ytw2nQ=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=Yey4wV9LTtGV3TuTImVjgvASalfXnFMYvU14RjMxv3mQnw+fX8T8qq89Zy9uMb8gL
         WJ1wNVofzza4+GX3oHLjexerykjhZ5F3R0X4cNCBJEIUjaUsPkJVjB0Qk3S8PGZK8Q
         80k8XeUvYcUrcJi0VUOFL43ADGlUYu9UWdxucVm4XkS4X/2zSqOTLRXUMd7hQvu+NW
         m6rUL3feTkiYKJ3cLmGqX7sv0u4xjC9Pb5Tg/hy0mAMQqBI/ESrwAKMguQb8LKV4Vh
         PpoaQr/Y9x9/SdGwdl3lWjcnGx7Ue5vu2Jysbva6pGgUWktyO4dM/tJ7oJ3WSHBX33
         gDKCYjCIMo3ig==
Received: by mail-pl1-f198.google.com with SMTP id h10-20020a170902f54a00b00166449db7f8so9618930plf.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 11:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :comments:mime-version:content-id:date:message-id;
        bh=1xC7xuJX2LwCqZhAFi0xIy8j41xevuej7OLQ+ytw2nQ=;
        b=MxHeEutOw/XNxYkdx2P65X0yfg+JmEzyAa+iHkB2ctCTeXRHZTMHdwB+dLTRKRYJRV
         0RcptJWIxr221kbmeOx0rp7JR/JiPi1K1RGZ6xqP1NzIdN9yhYQhfBpu1shLFKFwfh+D
         t+lUIvkgSjkeaOUE4BEeVf4TpuMJ6bCumgpQAY//fkPH4n2lnGZvwTwFN2Nd0lNjN5rB
         dMloS0vQGH+kkFJwwOQQHZF1zmlE6ZRyOjU9t4NG/A+NFl3qA8nuiJ/TclBaUsvBse7D
         YqwpjByX8wmwpppCodvV+s37KdEHKG9qBKZCb8S2TgBCW+oyqvSCKe2+jlPJMjbwOHNU
         fGsg==
X-Gm-Message-State: AOAM531qVYyKa7xeABid905p5JdnVCWEAF3HjaIaddsjho759e0WMgTX
        hikCqkwf2DCwoWIv7EV2dL8t2nsArE2GkWjUctltO7gpWagPn2jlp35IrZIDTSrphIY1Td8+rfk
        4iHWPf3oNHNjFfzTAm2v7p2hb/s+w2wTGmrYBe52C+g==
X-Received: by 2002:a17:902:bd09:b0:162:1497:de0a with SMTP id p9-20020a170902bd0900b001621497de0amr35553394pls.64.1654714377008;
        Wed, 08 Jun 2022 11:52:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz23ty9fYIWfgAEUEgkcxRCNjUJTs0y3pIhLc6xx8m3HBunMKZC4fUMAvhK8ymRAtXm6HpymA==
X-Received: by 2002:a17:902:bd09:b0:162:1497:de0a with SMTP id p9-20020a170902bd0900b001621497de0amr35553376pls.64.1654714376797;
        Wed, 08 Jun 2022 11:52:56 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.157])
        by smtp.gmail.com with ESMTPSA id x22-20020a63cc16000000b003f9e80538d0sm15196943pgf.17.2022.06.08.11.52.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jun 2022 11:52:56 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
        id F0F1A62730; Wed,  8 Jun 2022 11:52:55 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id E9D74A0B36;
        Wed,  8 Jun 2022 11:52:55 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Jonathan Toppins <jtoppins@redhat.com>
cc:     netdev@vger.kernel.org, Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [net-next v2 1/2] bonding: netlink error message support for options
In-reply-to: <57acf609e89a35d4ea6ff901b3be3c5bb0071f78.1654711315.git.jtoppins@redhat.com>
References: <cover.1654711315.git.jtoppins@redhat.com> <57acf609e89a35d4ea6ff901b3be3c5bb0071f78.1654711315.git.jtoppins@redhat.com>
Comments: In-reply-to Jonathan Toppins <jtoppins@redhat.com>
   message dated "Wed, 08 Jun 2022 14:14:56 -0400."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13032.1654714375.1@famine>
Date:   Wed, 08 Jun 2022 11:52:55 -0700
Message-ID: <13033.1654714375@famine>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Toppins <jtoppins@redhat.com> wrote:

>Add support for reporting errors via extack in both bond_newlink
>and bond_changelink.
>
>Instead of having to look in the kernel log for why an option was not
>correct just report the error to the user via the extack variable.
>
>What is currently reported today:
>  ip link add bond0 type bond
>  ip link set bond0 up
>  ip link set bond0 type bond mode 4
> RTNETLINK answers: Device or resource busy
>
>After this change:
>  ip link add bond0 type bond
>  ip link set bond0 up
>  ip link set bond0 type bond mode 4
> Error: unable to set option because the bond is up.
>
>Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
