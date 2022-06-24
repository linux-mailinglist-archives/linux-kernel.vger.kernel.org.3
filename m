Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9A455A2C6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiFXUdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFXUdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:33:36 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FCA3057E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=9rV7rmTUfpzPtlwowSz9p1z60VIIot0KQLA/WiXxBeA=;
        b=pHDkNdVf6STnjKUshSXvwCtLkvy1okgANpIqFeyr0zbeNDGVDqwZZ36iVmusEI3YbZMTKMU1gzpj3
         uIdecYgYU9bchEiyS3HNMg60xKyiVavfRz0ZXcg9s3ZEh1Xbq1/NZ4I8INTbnxi3kj7LSQLbHP3DyL
         +QJHmCddqNg+8LbSxxon87ukMKgIWdX7acJMiWjfqkCFYa4zN44Z9cKs7dZldps79g9u9R+b3D6dt7
         DWzCRl+FRz+1s/j77tVGMge7uwSKBhPb2KBd/d/3PxGg77+dbH89WQKaLK8GqIcNA5R5wk9V2/3pmn
         exhoG3U7vPepuW9l1Rl4broKKNqxMag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=9rV7rmTUfpzPtlwowSz9p1z60VIIot0KQLA/WiXxBeA=;
        b=WiJlVYaxeG1eVJ9QOAGe9bPNIpKx+3kKMa7EHEO8XjkvwvJOOk8h8v8gmOEXVv4NgbR7Cn/Jr4D27
         jVTs+9XCA==
X-HalOne-Cookie: d3783bc8887fa11d3fbd817fdcbe0ed542c9b62f
X-HalOne-ID: e9d1b734-f3fc-11ec-8233-d0431ea8bb10
Received: from mailproxy4.cst.dirpod4-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id e9d1b734-f3fc-11ec-8233-d0431ea8bb10;
        Fri, 24 Jun 2022 20:33:32 +0000 (UTC)
Date:   Fri, 24 Jun 2022 22:33:30 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     laurent.pinchart@ideasonboard.com, jagan@amarulasolutions.com,
        jonas@kwiboo.se, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com, robert.foss@linaro.org,
        andrzej.hajda@intel.com, alsi@bang-olufsen.dk,
        biju.das.jz@bp.renesas.com, maxime@cerno.tech
Subject: Re: [PATCH v2] drm: bridge: adv7511: Add check for
 mipi_dsi_driver_register
Message-ID: <YrYfmqJbRmGWh0qw@ravnborg.org>
References: <20220602103401.2980938-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602103401.2980938-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 06:34:01PM +0800, Jiasheng Jiang wrote:
> As mipi_dsi_driver_register could return error if fails,
> it should be better to check the return value and return error
> if fails.
> Moreover, if i2c_add_driver fails,  mipi_dsi_driver_register
> should be reverted.
> 
> Fixes: 1e4d58cd7f88 ("drm/bridge: adv7533: Create a MIPI DSI device")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Thanks, added to drm-misc (added to drm-misc-next as this did not look
like something that required fast forward to mainline).

	Sam
