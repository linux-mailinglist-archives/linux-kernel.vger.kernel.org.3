Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F3A50F31A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344340AbiDZH4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344369AbiDZHx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9364ABBE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650959419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgkVeFtk7kmhzt6NM7uvR8g8Xij0kTOqB1NgwHZ6ZsY=;
        b=a59q494ptKU78H9wmlev01aL+1O07FEawGMwH+AcNno+vcdP60afKnBN70DQVTupPmPWin
        jCeddQTo1ptMYgUwTpa+5REUAMusTduh7WV/qzasrj9rdEUHPq2E3i70YUhu5oE9vpMzwl
        xWa9Cxc6B22gdHc6w327Nh/IvI/C+2g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-QLIHlhc5MOyuKUKEui5Mtw-1; Tue, 26 Apr 2022 03:50:18 -0400
X-MC-Unique: QLIHlhc5MOyuKUKEui5Mtw-1
Received: by mail-wm1-f69.google.com with SMTP id az19-20020a05600c601300b003914ac8efb8so513101wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cgkVeFtk7kmhzt6NM7uvR8g8Xij0kTOqB1NgwHZ6ZsY=;
        b=TvnSHhIt/uaoQBCVh6WIUWZtmUtYt22DIq5VC67ftatkf8F52hZ0jLMGJzdy9DAYDZ
         l+cy6komuntKKJqzBUNaL6opxtAHghLO3VR/0A1SbwvYG0YomjjKDCSGD3CWPDs8n3Vq
         F7M8N9enSDcxrtjWBt60U2oE9twuch2Ma+cbO/BIYs4FFWV7zhNQxmIEy3SUN9qmxaBt
         vW5IvFnsLdxO2U643WBhWbJHfPcXvU9FkjnjLuoAnFLk/5hDdfbaEadECG++h9RZAPsx
         +kKMl9ukKdlfYpziwk15EtBw/fffoWfMr2Rb+cz30YhsXcEaZnm325zmwLrDjGL3WO5r
         Gr/Q==
X-Gm-Message-State: AOAM531AXpZb7K982xEiZj7CwrjvBkQsV67EnF1dQZIdZJUfl6UfBHy5
        Erp5IlQ46Vannj0FLs3uR/YQMDGN8U/JTggc1nsKqgxywwxjm8+O48ODdh/ciBh2ncRDg8ysRLq
        Ih6jlRG60o4vwLa7icc1j6+Uu
X-Received: by 2002:a05:600c:5c9:b0:38e:d44a:4cc1 with SMTP id p9-20020a05600c05c900b0038ed44a4cc1mr28698027wmd.124.1650959417063;
        Tue, 26 Apr 2022 00:50:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBXOpJmGEWozLGFN1CjEnuirBJfeA0Kz7+BA4MlA0zlr6UKrJpJpE31VOFYGB8/dXFdjuRBg==
X-Received: by 2002:a05:600c:5c9:b0:38e:d44a:4cc1 with SMTP id p9-20020a05600c05c900b0038ed44a4cc1mr28698015wmd.124.1650959416879;
        Tue, 26 Apr 2022 00:50:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-117-160.dyn.eolo.it. [146.241.117.160])
        by smtp.gmail.com with ESMTPSA id b14-20020a7bc24e000000b003899c8053e1sm11841188wmj.41.2022.04.26.00.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 00:50:16 -0700 (PDT)
Message-ID: <43773a65a27cb714e3319b06b0215fcb0471aae6.camel@redhat.com>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Skip cmode writable for mv88e6*41
 if unchanged
From:   Paolo Abeni <pabeni@redhat.com>
To:     Marek =?ISO-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Nathan Rossi <nathan@nathanrossi.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Date:   Tue, 26 Apr 2022 09:50:15 +0200
In-Reply-To: <20220423152523.1f38e2d8@thinkpad>
References: <20220423132035.238704-1-nathan@nathanrossi.com>
         <20220423152523.1f38e2d8@thinkpad>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 2022-04-23 at 15:25 +0200, Marek Behún wrote:
> On Sat, 23 Apr 2022 13:20:35 +0000
> Nathan Rossi <nathan@nathanrossi.com> wrote:
> 
> > The mv88e6341_port_set_cmode function always calls the set writable
> > regardless of whether the current cmode is different from the desired
> > cmode. This is problematic for specific configurations of the mv88e6341
> > and mv88e6141 (in single chip adddressing mode?) where the hidden
> > registers are not accessible.
> 
> I don't have a problem with skipping setting cmode writable if cmode is
> not being changed. But hidden registers should be accessible regardless
> of whether you are using single chip addressing mode or not. You need
> to find why it isn't working for you, this is a bug.

For the records, I read the above as requiring a fix the root cause, so
I'm not applying this patch. Please correct me if I'm wrong.

Thanks,

Paolo

