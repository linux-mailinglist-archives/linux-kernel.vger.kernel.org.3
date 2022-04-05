Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04814F4A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444871AbiDEWfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457989AbiDERDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:03:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0605860DA4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:01:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d5so24308168lfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EhE3xEj7yTaKmn7cftZnafvMypbMiXwgf4Mz1OcfgBg=;
        b=lOsVIxXgyLw1bbuonyQ+6J95XWOlIKSAvozYTUSNESPEwUurIFSwO83vWvl3nF2MBD
         3wmnsOCeDDX6uWLZDA5vNIaXVNQH3jySbWVWvMLfj/3ZnrVRePqEsH6s4soxqYv40puY
         LlLsO/d4o4eMbyfBOCL2DTIQ4s8bK2hxgcTIRwPVAPnYCG2Sl/rmeXhmigLhC6uUtfrW
         v44W9mrPOlsxgzG3/L3r4ZVEw/uh+1muxNhfcHxozbCm8OWeta3pvLNp3Wu3OQdb5w6u
         G++8hk/HAPtOUebaVL6NgdTeUeMJsexGIjmpEL26AYNwSMF2dklT9o5CjbQdV7bUfFEI
         AEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EhE3xEj7yTaKmn7cftZnafvMypbMiXwgf4Mz1OcfgBg=;
        b=nxu3SOlnne1/uxJDH2aPrjCmc/d+nI0K8VkQOjHScCyurAc3d6O+pq/yb0myBRZ34o
         i8Zgyz3uhk3cMHAALGm98+aNF6mC79YkBkObdkA1bl2l2dSyNliCI9ymi+a83TN2FyVk
         /7jFdEdVdeheOrVDn6AF/r57fEJ0GLrFhvZrmO6k0U79ZoABbjY6mx3sMq9Ssk2RFBNV
         GUMCSWFmcL+Vkvc1CbOj8w57LixRhA4OjYOLX51iAlHU9KCPfKJqttn1fWSXTccvUIA1
         mQd1U98LLo9xVXSbTCww8+jbIeSC2NKJ43jmaqqPZkevMko6qYvny+tYvjyFOJ0JRqo0
         voPw==
X-Gm-Message-State: AOAM531Lm6x5h5hXgkciMkgBh2CjmMIaQ9dkMgq2KDCGWa6Uv03hN/JD
        RBgMvsqA97ZrtZL9tCLeMq8=
X-Google-Smtp-Source: ABdhPJxdyhEhx3Oy3KqZw5PM7lrlcK1yJXCNYWYb9LypIihDqvGdwlFY8Y76QIJQS2OaT89Zm2xDDQ==
X-Received: by 2002:ac2:4569:0:b0:44a:de90:e495 with SMTP id k9-20020ac24569000000b0044ade90e495mr3253977lfm.352.1649178061017;
        Tue, 05 Apr 2022 10:01:01 -0700 (PDT)
Received: from orome (pd9e518f7.dip0.t-ipconnect.de. [217.229.24.247])
        by smtp.gmail.com with ESMTPSA id 2-20020ac24d42000000b0044ad39c6c83sm1554336lfp.158.2022.04.05.10.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 10:00:59 -0700 (PDT)
Date:   Tue, 5 Apr 2022 19:00:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3] drm: of: Properly try all possible cases for
 bridge/panel detection
Message-ID: <Ykx1yQGROqyiu/yJ@orome>
References: <20220329132732.628474-1-paul.kocialkowski@bootlin.com>
 <YkZulslrzeurp43U@ripper>
 <YkatbpubQjwBWOiK@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G3PF1PcGvTi6lpvg"
Content-Disposition: inline
In-Reply-To: <YkatbpubQjwBWOiK@aptenodytes>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G3PF1PcGvTi6lpvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 01, 2022 at 09:44:46AM +0200, Paul Kocialkowski wrote:
> Hi Bjorn,
>=20
> On Thu 31 Mar 22, 20:16, Bjorn Andersson wrote:
> > On Tue 29 Mar 06:27 PDT 2022, Paul Kocialkowski wrote:
> >=20
> > > While bridge/panel detection was initially relying on the usual
> > > port/ports-based of graph detection, it was recently changed to
> > > perform the lookup on any child node that is not port/ports
> > > instead when such a node is available, with no fallback on the
> > > usual way.
> > >=20
> > > This results in breaking detection when a child node is present
> > > but does not contain any panel or bridge node, even when the
> > > usual port/ports-based of graph is there.
> > >=20
> > > In order to support both situations properly, this commit reworks
> > > the logic to try both options and not just one of the two: it will
> > > only return -EPROBE_DEFER when both have failed.
> > >=20
> >=20
> > Thanks for your patch Paul, it fixed a regression on a device where I
> > have a eDP bridge with an of_graph and a aux-bus defined.
> >=20
> > But unfortunately it does not resolve the regression I have for the
> > USB based DisplayPort setup described below.
> >=20
> >=20
> > In the Qualcomm DisplayPort driver We're calling:
> >=20
> > 	devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
> >=20
> > and with the following DT snippet the behavior changed:
> >=20
> > displayport-controller@ae90000 {
> > 	compatible =3D "qcom,sc8180x-dp";
> > 	...
> >=20
> > 	operating-points-v2 =3D <&dp0_opp_table>;
> >=20
> > 	ports {
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <0>;
> >=20
> > 		port@0 {
> > 			reg =3D <0>;
> > 			dp0_in: endpoint {
> > 				remote-endpoint =3D <&display_driver>;
> > 			};
> > 		};
> > 	};
> >=20
> > 	dp0_opp_table: opp-table {
> > 		...;
> > 	};
> > };
> >=20
> > Prior to the introduction of 80253168dbfd ("drm: of: Lookup if child
> > node has panel or bridge") this would return -ENODEV, so we could
> > differentiate the case when we have a statically defined eDP panel from
> > that of a dynamically attached (over USB) DP panel.
> >=20
> > Prior to your change, above case without the opp-table node would have
> > still returned -ENODEV.
> >=20
> > But now this will just return -EPROBE_DEFER in both cases.
>=20
> Oh that's right, the -ENODEV case was just completely removed by my chang=
e.
> Initially this would happen if !of_graph_is_present or if the remote node
> doesn't exist.
>=20
> Now that we are also checking for child nodes, we can't just return -ENOD=
EV
> when the graph or remote node is missing: we must also check that there i=
s no
> child node that is a panel/bridge.
>=20
> For the graph remote case, we can reliabily return -EPROBE_DEFER when
> of_graph_is_present and the remote exists and of_device_is_available.
> Otherwise we can go for -ENODEV. I think getting -EPROBE_DEFER at this po=
int
> should stop the drm_of_find_panel_or_bridge process.
>=20
> On the other hand for the child panel/bridge node case, I don't see how we
> can reliably distinguish between -EPROBE_DEFER and -ENODEV, because
> of_drm_find_panel and of_drm_find_bridge will behave the same if the child
> node is a not-yet-probed panel/bridge or a totally unrelated node.
> So I think we should always return -EPROBE_DEFER in that case.
>=20
> As a result you can't get -ENODEV if using the of graph while having any
> (unrelated) child node there, so your issue remains.
>=20
> Do you see any way we could make this work?
>=20
> > I thought the appropriate method of referencing the dsi panel was to
> > actually reference that using the of_graph, even though it's a child of
> > the dsi controller - that's at least how we've done it in e.g. [1].
> > I find this to be much nicer than to just blindly define that all
> > children of any sort of display controller must be a bridge or a panel.
>=20
> Yes I totally agree. Given that using the child node directly apparently
> can't allow us to distinguish between -EPROBE_DEFER/-ENODEV I would be in
> favor of dropping this mechanism and going with explicit of graph in any =
case
> (even if it's a child node). I don't see any downside to this approach.
>=20
> What do yout think?

This patch has recently starting causing failures on various Tegra
devices that use drm_of_find_panel_or_bridge() for the case where the
output might be connected to an eDP or LVDS panel. However, that same
output could also be connected to an HDMI or DP monitor, in which case
we obviously don't want a DT representation because it's all
discoverable.

If I understand correctly, that's similar to what Bjorn described. In my
case I was able to fix the regression by returning -ENODEV at the very
end of the function (i.e. no matching ports were found and no graph is
present).

Thierry

--G3PF1PcGvTi6lpvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJMdcYACgkQ3SOs138+
s6G+FRAAteqUytCKBjVXrgayROapTBFjx8hTV88Y88uTqPW97kVaniy2tNZNK07I
seH5o1SGPWam/5s/INXKwQ2RH3AOcIBSpvbVQFwDQRjXwjGcO7JuuBmFMNTlcuOD
jqRbOawWCQt8uecnZmPPaLAGhg8zg2M2cAZflhqiQKy0F8ivdEfNkysZhU3Gc7v+
jJihDHnPq2ot8HyvzYLKTl4Zf1CvJTkzYF5YPRhYDLPoQv+qHQd33U8dDmBFhJGk
19FK0yLkpoGLM0jWWKsmiMuLHZ4u7y+lvmc3sKUafwjfzW1YgR9gq2I5kpWnWKlX
0pDVPZG9lhuUHylKfrynzNWmS33KfdZViMgJgFd6NDkGVK0znnYOzYwhPiAJwQ+Q
KD6SolpKJa82N9YYMnLUIPq9unmNnONWhY4VayfZYirOzf/4xjTYdtD6QWTkI3K+
RCAgTk3QP0/hI+ZYFUdOqST/9Y9lYc1u/RlHgQjBF79pAYZcC9wp7eONvYHBgDK9
k+CqExIzOc9EoCPxEbbSL1nsHg4hDa3Ct//1O4+zSbZe41hvO1ayA4Vl2TxM8cgG
ELttCZZ5R879I+1IZL5ll0Ikw6RkRkZ5mplg4tfn2AJM7uYep4kkw6vvnfcsF2vS
fAb9KrbHRCM+o76prnQfq3j4TrUZEeGOietyUPpBwXuUgbPAw0A=
=zt/2
-----END PGP SIGNATURE-----

--G3PF1PcGvTi6lpvg--
