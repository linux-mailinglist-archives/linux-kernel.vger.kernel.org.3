Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C382E544B08
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244691AbiFILuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbiFILum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E2940F27B;
        Thu,  9 Jun 2022 04:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC5F160B0C;
        Thu,  9 Jun 2022 11:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC74C34114;
        Thu,  9 Jun 2022 11:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654775440;
        bh=gATZaLIUmZR0d4Dmyav0+IhccKug7Z/4zmtUfvd5RJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDQHg5r1bCeF77ifffkA8E0SdS22TUjUb0z/nq1nwqUqCCeVG6Z0j6BkRhQs6y5c1
         hgPdv+j7ZW4EPvt8V5X1AINKEDLB0inQKYtiqFAm39H1+e3HSTWiXP8stv5Cx19Guv
         ZgthtHps0dmgh4+5GMGHbs+PJQazuj6olM6aMmn4ytw7p7gKIkHGxrbb78werfnkgY
         AhiGGmxPM+HSzPUR3I80FTyevRAQ2VDgu7Dtf2K9olvpQsuM8v3/Jp7j6C6CI3d7TL
         /ERtIPEstLy9yo6HcSAnUByX5kv8uT8aSQRCCyE3B+uR//s7FiXqG9vwYlUYVX/XkE
         7g9cC1xBXgihQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nzGgO-0000wl-1B; Thu, 09 Jun 2022 13:50:36 +0200
Date:   Thu, 9 Jun 2022 13:50:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: qcom: gdsc: add support for collapse-vote
 registers
Message-ID: <YqHejM86/T0f3Vt+@hovoldconsulting.com>
References: <20220520100948.19622-1-johan+linaro@kernel.org>
 <20220520100948.19622-3-johan+linaro@kernel.org>
 <20220521035228.1FD9AC385A9@smtp.kernel.org>
 <Yot4XHaf6uHcJxTL@hovoldconsulting.com>
 <20220526183219.9F047C385A9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526183219.9F047C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 11:32:17AM -0700, Stephen Boyd wrote:
> Quoting Johan Hovold (2022-05-23 05:04:44)
> > On Fri, May 20, 2022 at 08:52:26PM -0700, Stephen Boyd wrote:
> > > Quoting Johan Hovold (2022-05-20 03:09:47)
> > > > Recent Qualcomm platforms have APCS collapse-vote registers that allow
> > > > for sharing GDSCs with other masters (e.g. LPASS).
> > > 
> > > Maybe just say 'with other subsystems' because LPASS is an entire
> > > subsystem.
> > 
> > The term "subsystem" is too broad and also has a different meaning in
> > Linux.
> > 
> > The vendor kernel uses "masters" here which is clear enough and
> > presumably matches their documentation.
> > 
> 
> How about "voter"? Then it isn't confused with linux subsystems.

Yeah, voters vote, but that's not very informative, is it?

I don't see any reason to obfuscate the commit message here.

Johan
