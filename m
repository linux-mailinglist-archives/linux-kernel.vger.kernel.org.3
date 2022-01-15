Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A967948F999
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 22:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiAOVpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 16:45:25 -0500
Received: from comms.puri.sm ([159.203.221.185]:58972 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233774AbiAOVpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 16:45:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C02EBE047F;
        Sat, 15 Jan 2022 13:44:53 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fMTOmewtWuMg; Sat, 15 Jan 2022 13:44:53 -0800 (PST)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel@puri.sm
Subject: Re: [PATCH] thermal: qoriq: Only enable sites that actually exist
Date:   Sat, 15 Jan 2022 22:44:43 +0100
Message-ID: <4680217.GXAFRqVoOG@pliszka>
In-Reply-To: <4a470e25-b1fa-bf7b-18d2-d21cbfe4fb3a@linaro.org>
References: <20211129110252.1699112-1-sebastian.krzyszkowiak@puri.sm> <4a470e25-b1fa-bf7b-18d2-d21cbfe4fb3a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1804073.tdWV9SEqCh"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1804073.tdWV9SEqCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To: linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Amit Kucheria <amitk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, kernel@puri.sm
Subject: Re: [PATCH] thermal: qoriq: Only enable sites that actually exist
Date: Sat, 15 Jan 2022 22:44:43 +0100
Message-ID: <4680217.GXAFRqVoOG@pliszka>
In-Reply-To: <4a470e25-b1fa-bf7b-18d2-d21cbfe4fb3a@linaro.org>
References: <20211129110252.1699112-1-sebastian.krzyszkowiak@puri.sm> <4a470e25-b1fa-bf7b-18d2-d21cbfe4fb3a@linaro.org>

Hi Daniel,

On wtorek, 30 listopada 2021 16:13:02 CET Daniel Lezcano wrote:
> Hi Sebastian,
> 
> thanks for the fix.
> 
> On 29/11/2021 12:02, Sebastian Krzyszkowiak wrote:
> > On i.MX8MQ, enabling monitoring sites that aren't connected to anything
> > can cause unwanted side effects on some units. This seems to happen
> > once some of these sites report out-of-range readings and results in
> > sensor misbehavior, such as thermal zone readings getting stuck or even
> > suddenly reporting an impossibly high value, triggering emergency
> > shutdowns.
> > 
> > The datasheet lists all non-existent sites as "reserved" and doesn't
> > make any guarantees about being able to enable them at all, so let's
> > not do that.
> 
> The description of what does the patch is missing here.

Does this appended to commit description sound good?

"Instead, iterate over sensor DT nodes and only enable monitoring sites that 
are specified there prior to registering their thermal zones."

> > Fixes: 45038e03d633 ("thermal: qoriq: Enable all sensors before
> > registering them")
> > 
> > Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> > ---
> > 
> >  drivers/thermal/qoriq_thermal.c | 63 ++++++++++++++++++++++-----------
> >  1 file changed, 43 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/thermal/qoriq_thermal.c
> > b/drivers/thermal/qoriq_thermal.c index 73049f9bea25..ef0848849ee2 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -32,7 +32,6 @@
> > 
> >  #define TMR_DISABLE	0x0
> >  #define TMR_ME		0x80000000
> >  #define TMR_ALPF	0x0c000000
> > 
> > -#define TMR_MSITE_ALL	GENMASK(15, 0)
> > 
> >  #define REGS_TMTMIR	0x008	/* Temperature measurement 
interval Register */
> >  #define TMTMIR_DEFAULT	0x0000000f
> > 
> > @@ -129,33 +128,51 @@ static const struct thermal_zone_of_device_ops
> > tmu_tz_ops = {> 
> >  static int qoriq_tmu_register_tmu_zone(struct device *dev,
> >  
> >  				       struct qoriq_tmu_data 
*qdata)
> >  
> >  {
> > 
> > -	int id;
> > +	int ret = 0;
> > +	struct device_node *np, *child, *sensor_np;
> > 
> > -	if (qdata->ver == TMU_VER1) {
> > -		regmap_write(qdata->regmap, REGS_TMR,
> > -			     TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
> > -	} else {
> > -		regmap_write(qdata->regmap, REGS_V2_TMSR, 
TMR_MSITE_ALL);
> > -		regmap_write(qdata->regmap, REGS_TMR, TMR_ME | 
TMR_ALPF_V2);
> > -	}
> > +	np = of_find_node_by_name(NULL, "thermal-zones");
> > +	if (!np)
> > +		return -ENODEV;
> > +
> > +	sensor_np = of_node_get(dev->of_node);
> > 
> > -	for (id = 0; id < SITES_MAX; id++) {
> > +	for_each_available_child_of_node(np, child) {
> > 
> >  		struct thermal_zone_device *tzd;
> > 
> > -		struct qoriq_sensor *sensor = &qdata->sensor[id];
> > -		int ret;
> > +		struct qoriq_sensor *sensor;
> > +		int id, site;
> > +
> > +		ret = thermal_zone_of_get_sensor_id(child, sensor_np, 
&id);
> > +
> > +		if (ret < 0) {
> > +			dev_err(dev, "failed to get valid sensor id: 
%d\n", ret);
> > +			of_node_put(child);
> > +			break;
> > +		}
> > 
> > +		sensor = &qdata->sensor[id];
> > 
> >  		sensor->id = id;
> > 
> > +		/* Enable monitoring */
> > +		if (qdata->ver == TMU_VER1) {
> > +			site = 0x1 << (15 - id);
> > +			regmap_update_bits(qdata->regmap, REGS_TMR,
> > +					   site | TMR_ME | 
TMR_ALPF,
> > +					   site | TMR_ME | 
TMR_ALPF);
> > +		} else {
> > +			site = 0x1 << id;
> > +			regmap_update_bits(qdata->regmap, 
REGS_V2_TMSR, site, site);
> > +			regmap_write(qdata->regmap, REGS_TMR, TMR_ME 
| TMR_ALPF_V2);
> > +		}
> 
> Why not create the site mask in the loop and then call once the block
> above out this loop?

That's how it worked in the past. The entire point of this patch is to not do 
that - otherwise we could simply revert 45038e03d633 and bring back the issue 
it was attempting to fix (bogus data being reported prior to the first reading).

> 
> >  		tzd = devm_thermal_zone_of_sensor_register(dev, id,
> >  		
> >  							   
sensor,
> >  							   
&tmu_tz_ops);
> > 
> > -		ret = PTR_ERR_OR_ZERO(tzd);
> > -		if (ret) {
> > -			if (ret == -ENODEV)
> > -				continue;
> > -
> > -			regmap_write(qdata->regmap, REGS_TMR, 
TMR_DISABLE);
> > -			return ret;
> > +		if (IS_ERR(tzd)) {
> > +			ret = PTR_ERR(tzd);
> > +			dev_err(dev, "failed to register thermal 
zone: %d\n", ret);
> > +			of_node_put(child);
> > +			break;
> > 
> >  		}
> >  		
> >  		if (devm_thermal_add_hwmon_sysfs(tzd))
> > 
> > @@ -164,7 +181,13 @@ static int qoriq_tmu_register_tmu_zone(struct device
> > *dev,> 
> >  	}
> > 
> > -	return 0;
> > +	of_node_put(sensor_np);
> > +	of_node_put(np);
> > +
> > +	if (ret)
> > +		regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
> > +
> > +	return ret;
> > 
> >  }
> >  
> >  static int qoriq_tmu_calibration(struct device *dev,

Cheers,
Sebastian
--nextPart1804073.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIt2frgBqEUNYNmF86PI1zzvbw/8FAmHjQEsACgkQ6PI1zzvb
w/9GiA/9Go8pgwmHV7YRUvB0CyqAErUeowboQzgX3S31RqzP9OW9TI8w8Md3nC54
Xjf13qWselt0VvD2YI+TIRk4SFUpKMihFjETmfD0mAVqMqXtIOwqY9Oag5gp2YYG
ZtX2K/6Upkhdt8lkh/EJPOeUBWUhEP0UN7RmhZjnaHPQ6UH6EDwkRvJvLiihkwI5
YchFV0iKyw0jkL10gp3mZuZ9f8vUNvylLR7ox7QoGIX109crhVSzQ5vxkWFgU6qR
v95mlBuS74cIcAga5aGoT5IDYvUyod8ogzM5KIqKskxj2IUl3tAXQwQA5knLgfLC
f3YmRN+5CrkANiCuFnbeqV1gm+x9b5ge/WIE7PZuR77vG86zG9jHRZ22M4U1k8Ri
am0o5dqjVTNXNkgzanM/pWmi6R5LBnEye/bAnOh1GZlFWm6RnKdQ3eQ1l0h9YzHy
gOCqbMNZ1e39fWOhG6+CnQI/4RMe6lGbXJvobjJzRbCQdGCEX/o+7vLZ0xPEVjaP
qEmbY4h7SNwxGXyrGDob0VqGbY3fhfVtBG8Um+/7ltY3gScBUVvaDLwEdplyhWDd
ZkGInMkdGwSyUxbL5BKlaEYVA7wI/MtLPgPatx2xDomMVv3mjLWe9IuNsoAKMNGS
yTkbdWo19tNWmryXYSXEce/pzHI9epCPbUnVTBXtd5nf6P2qSj0=
=LFum
-----END PGP SIGNATURE-----

--nextPart1804073.tdWV9SEqCh--



