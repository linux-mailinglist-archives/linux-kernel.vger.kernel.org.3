Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A1D4B2EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353132AbiBKUyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:54:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiBKUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:54:09 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2FCB5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:54:07 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c3so5628904pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vyS8enjp3MoFhalQV38fhwt/m4nt1gdOZVHuo1kTc9Q=;
        b=TeZsjJVypJgjEKoHluoc/XfLqXIwLe3CWDguw5qoWU9aVUkTRs5QNxp+mxBNFGWY8I
         IetHveD0ZZHP+WHWN0td99bGJgS/HFlRS6EvikFaOBopIzIL/LX7CpWCBSq+ogeITa/i
         lQT8bAqiOu0XfYtFAmLinXe8UWVo/K1HqY1lFDOCBX1A02IKEuQjNb3aHPrYqWRtN7Xx
         MRkDv/8kvEfb7nKZSfMw+9XMWtFfHDSHALr8FvIOTZ7zoMe6S8hW34F0WvDdF7fO4yOl
         0JZmQuo0SEau2TQZqmm0MO36doMmYHAeFeuqa5ArofmfZ7taCevdR/7cl9JDhSGK9+Uu
         59VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vyS8enjp3MoFhalQV38fhwt/m4nt1gdOZVHuo1kTc9Q=;
        b=jwcQ5ytENBMqmPzN9Gtr+hh5OMw2cu85WLnhHmEEZbGIdUZmC8vLpYA8j2CZTNx+Fz
         KFr+GBQ8DI1STb0cpgyHp1hMCBLvSAIUROvMs4EtWde6Uw8F3wVJijduhmNa1Rkp208J
         3fbzJA89yH9GL8C5fNvpKlUZy6G5VlT1N2WsN51u3g5CEOM1BcsVXkkrSbMHqh5xGWgL
         n22wI479czz/eVKnAK15/07f0OLEYX3yqaS0rm0lCkRRGIAp/88XRGqu0/rOScW3X1i3
         FIwJ9mrjaS9EbxTky3tTmpj5v8SAskOhXSypcZOqHcjfWpkhGOZ3ziDqEAjMXbsQ6FpD
         F3Xw==
X-Gm-Message-State: AOAM530Ym+/iiOZHJNJcMNn1cQ9w0JKc5Xqu1vzErcBiikNji2e6ACgs
        NLOqfNBmyHJ/F/AezBUizGYCmA==
X-Google-Smtp-Source: ABdhPJx4dfsIqmmZ6a/E1jxZB/gsh98/+uLWnFAbi9FRThvagfZHmHl8p1aQgBOjvYP4R7+ULg3qGg==
X-Received: by 2002:a17:902:f68f:: with SMTP id l15mr3376435plg.169.1644612846949;
        Fri, 11 Feb 2022 12:54:06 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id f3sm28492008pfe.43.2022.02.11.12.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:54:06 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: remove CPU opps below 1GHz for G12B/SM1
In-Reply-To: <C70293C2-8CE8-42CE-911A-E0CC3DFB82FC@gmail.com>
References: <20220209135535.29547-1-christianshewitt@gmail.com>
 <7h7da3o6cg.fsf@baylibre.com>
 <C70293C2-8CE8-42CE-911A-E0CC3DFB82FC@gmail.com>
Date:   Fri, 11 Feb 2022 12:54:06 -0800
Message-ID: <7ha6exm8ep.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

>> On 10 Feb 2022, at 5:31 am, Kevin Hilman <khilman@baylibre.com> wrote:
>>=20
>> Christian Hewitt <christianshewitt@gmail.com> writes:
>>=20
>>> Amlogic G12B and SM1 devices experience CPU stalls and random board
>>> wedges when the system idles and CPU cores clock down to lower opp
>>> points. Recent vendor kernels include a change to remove 100-250MHz
>>> (with no explanation) [0] but other downstream sources also remove
>>> the 500/667MHz points (also with no explanation). Unless 100-667Mhz
>>> opps are removed or the CPU governor forced to performance, stalls
>>> are observed, so let's remove them an improve stability/uptime.
>>=20
>> Just curious: what CPUfreq governor do you use by default for the
>> LibreELEC kernel?
>
> LE uses ondemand. One of the original clues on the problem us that the
> issue isn=E2=80=99t seen in some of the retro-gaming forks on LE's codeba=
se
> which use the performance governor (and overclocks, etc.)

OK, thanks.  And does LE ever do full system suspend/resume?  Are things
stable for you across multiple suspend/resume cycles on G12B or SM1
devices?

I'm seeing hat with either powersave or performance, repeated
suspend/resume is stable, but with ondemand or schedultil it's not, even
with $SUBJECT patch applied.

If you have some time to test, seeing how long this loop[1] runs with
ondemand vs performance or powersave would be instructive.

Even more interesting...  if I set the governor to performance, but set
the suspend OPP to 1GHz[2] (which is what it would be for the powersave
governor), it is also unstable.  This suggests (to me) that any sort of
OPP change during the suspend/resume process is going to be unstable.
Now the challenge is to understand why so we can avoid it.

Thanks,

Kevin

[1]
while true;  do
    echo "=3D=3D=3D SUSPEND =3D=3D=3D"
    cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
    cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq
    cat /sys/devices/system/cpu/cpufreq/policy2/scaling_governor
    cat /sys/devices/system/cpu/cpufreq/policy2/scaling_cur_freq
    echo rtcwake -d rtc0 -m mem -s4
    echo "=3D=3D=3D RESUME =3D=3D=3D"
    sleep 4
done

[2]
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi b/arch/arm64=
/boot/dts/amlogic/meson-g12b-s922x.dtsi
index 1e5d0ee5d541..37da8be85288 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
@@ -14,6 +14,7 @@ cpu_opp_table_0: opp-table-0 {
 		opp-100000000 {
 			opp-hz =3D /bits/ 64 <100000000>;
 			opp-microvolt =3D <731000>;
+ 		        opp-suspend;
 		};
=20
 		opp-250000000 {
@@ -79,6 +80,7 @@ cpub_opp_table_1: opp-table-1 {
 		opp-100000000 {
 			opp-hz =3D /bits/ 64 <100000000>;
 			opp-microvolt =3D <751000>;
+ 		        opp-suspend;
 		};
=20
 		opp-250000000 {
