Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF0A53EE9A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiFFT2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiFFT2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:28:46 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C39101B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=TgDihkH46ScClTSETfwqhaOdnc1k4sLTbZgl+nfhbY8=;
        b=FcYUSxOBeC3/3TSClpuNV4GNrV3iOrNNyrWN6NwR4YFpuOA9htQSBDA4jDlQACv62Jk5XCXFZmI6n
         iw+3JRfyWrgmSpK0I2zsukxj+p+bKHACwwusz5ZgrzvoREHTnjoVWRRmBc7wjUJ+jd6hXHoN3+n3U5
         PqSajIfSI09v29OJT37rk84N2nE+GSfy+S0CB6lBrqfGeEu8FIhkSO7B2FrC2+XrBond1oLjpVDpY5
         MFfYqNGcusKGHptchBiXHLYwV2nW9iLpaEZxe0h2QATkz3YJDF+lKxj33rXn4IQZWTkhOCry4UxMt/
         7Q745JTlZm/KCSwRPaXmJqQH5q6bf2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=TgDihkH46ScClTSETfwqhaOdnc1k4sLTbZgl+nfhbY8=;
        b=EEHshRn2hLMK6AbLweFjaENfWd0Dr3h7mvknN5bPcKlCRgP3UmSGxxVtmrTWx9TuGMlGISYw2A++M
         1q51q4VDg==
X-HalOne-Cookie: f9fa9657bbf05a6c012e61f3fb9ae7e606a7e2db
X-HalOne-ID: dfa5331a-e5ce-11ec-a911-d0431ea8a290
Received: from mailproxy1.cst.dirpod3-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id dfa5331a-e5ce-11ec-a911-d0431ea8a290;
        Mon, 06 Jun 2022 19:28:42 +0000 (UTC)
Date:   Mon, 6 Jun 2022 21:28:40 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] Add a panel API to return panel orientation
Message-ID: <Yp5VaBd8slSSnQAs@ravnborg.org>
References: <20220606152431.1889185-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606152431.1889185-1-hsinyi@chromium.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,
thanks for this nice series.

On Mon, Jun 06, 2022 at 11:24:23PM +0800, Hsin-Yi Wang wrote:
> Panels usually call drm_connector_set_panel_orientation(), which is
> later than drm/kms driver calling drm_dev_register(). This leads to a
> WARN()[1].
> 
> The orientation property is known earlier. For example, some panels
> parse the property through device tree during probe.
> 
> The series add a panel API drm_panel_get_orientation() for drm/kms
> drivers. The drivers can use the API to get panel's orientation, so they
> can call drm_connector_set_panel_orientation() before drm_dev_register().
> 
> Panel needs to implement .get_orientation callback to return the property.

The following comment appears in every panel driver:
+       /*
+        * drm drivers are expected to call drm_panel_get_orientation() to get
+        * panel's orientation then drm_connector_set_panel_orientation() to
+        * set the property before drm_dev_register(). Otherwise there will be
+        * a WARN_ON if orientation is set after drm is registered.
+        */

Please move it to the drm_panel c or h file, it is noise to add it to
all panel drivers.

	Sam
