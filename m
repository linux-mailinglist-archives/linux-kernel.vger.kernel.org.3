Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9930A4959E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378690AbiAUGZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:25:37 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53524
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348827AbiAUGZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:25:36 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EA79C40052
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642746328;
        bh=i9Ze4chfphs7HSToLW+VPmaVGM0gBG5wn9WWFVp0dKo=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=tGSu6uw/iMD7LEGjHmnoBnd7xB7wnihJkiQexFnLvgO0+jgHSx/3GQdx+C6EujU+9
         ZoOxRoDtA/Ky91TY83B2vul76UPPhbNepAv/1t8UytWkmYninDhW2cTCCF153Bf8hN
         uF/ftwdB5pduaFJyqu784Edv6US7TlIG/ssmqRfSshSK4gKEP84yn5YacZuxf2Qegk
         a3uvJcKv2sB8pkWkJhdeKV7VOI70dRkE0DYlBEveTtP8K8008Br9wD/t2GG37hXUvl
         hxRG2Klai+lba2ohVwVLwg78YvUwIijbOVW9vR+VRAEPKXlAWXSMJ26qxJGEZLPLdj
         oP2aq1ImHqSDw==
Received: by mail-pg1-f198.google.com with SMTP id t18-20020a63dd12000000b00342725203b5so5126481pgg.16
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 22:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :comments:mime-version:content-id:content-transfer-encoding:date
         :message-id;
        bh=i9Ze4chfphs7HSToLW+VPmaVGM0gBG5wn9WWFVp0dKo=;
        b=mI56bowTT//gvvHf0/w43LUIrh4NSJye1hl/yVgXBFLzQHQ04VPPcCRiABboqMgks/
         jjySWv7FOuyU+mqmwL+9K1JFTf7jbgiVFmjWSysQkYbpvuLvY6KBLkMEsKyOzL/sJ520
         XYyx55wXRMRb4ZQT8NBSZhPj1YaDIp6Lfw2eIfwk6HmPwa1Eo3Z6KiBwBwuv+lqX2Lc2
         FFAy15XrMY0LlecLlOPzPkgk/OpfwIy7oSKpvKha9genbsIpxgqInRm2uh1f0IW+OFKU
         cxU20xDtvEy4L01nGDuVxYg4TDlxWvR08+1YtDBstmNlWSzu2M6Xph/4pc+HdXSQEC1Y
         /cdw==
X-Gm-Message-State: AOAM531vInZQaTJlfkIdYWEp+FRI4J1HZ0LN/KhRK6pC+vH3lU5fh0W+
        nj69XtZV8ag1omjDxL34tsG+VnappuPx8vSsVUeQxs1DbW/nXQjgzDiU+C24vbNClY590ViUGcD
        UCX9fniDWEsS0xsEohJP2kc2ECg6xVFx1LWyPr6W8VQ==
X-Received: by 2002:a17:903:22ca:b0:14a:74e6:b994 with SMTP id y10-20020a17090322ca00b0014a74e6b994mr2720955plg.87.1642746327525;
        Thu, 20 Jan 2022 22:25:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZ1YnUWKQJfdmy48bT3s6TU1mjeOaaBYK0f7fZ21BvGoF+6Y97eV3+xhR/02gZFy2dN6sWtg==
X-Received: by 2002:a17:903:22ca:b0:14a:74e6:b994 with SMTP id y10-20020a17090322ca00b0014a74e6b994mr2720936plg.87.1642746327298;
        Thu, 20 Jan 2022 22:25:27 -0800 (PST)
Received: from famine.localdomain ([50.125.80.157])
        by smtp.gmail.com with ESMTPSA id 202sm4104386pga.72.2022.01.20.22.25.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jan 2022 22:25:26 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
        id 5E7CF6093D; Thu, 20 Jan 2022 22:25:26 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 56D85A0B22;
        Thu, 20 Jan 2022 22:25:26 -0800 (PST)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Sun Shouxin <sunshouxin@chinatelecom.cn>
cc:     vfalico@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyd12@chinatelecom.cn
Subject: Re: [PATCH v6] net: bonding: Add support for IPV6 ns/na to balance-alb/balance-tlb mode
In-reply-to: <20220118073317.82968-1-sunshouxin@chinatelecom.cn>
References: <20220118073317.82968-1-sunshouxin@chinatelecom.cn>
Comments: In-reply-to Sun Shouxin <sunshouxin@chinatelecom.cn>
   message dated "Tue, 18 Jan 2022 02:33:17 -0500."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29468.1642746326.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 20 Jan 2022 22:25:26 -0800
Message-ID: <29469.1642746326@famine>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun Shouxin <sunshouxin@chinatelecom.cn> wrote:

>Since ipv6 neighbor solicitation and advertisement messages
>isn't handled gracefully in bonding6 driver, we can see packet
>drop due to inconsistency bewteen mac address in the option
>message and source MAC .
>
>Another examples is ipv6 neighbor solicitation and advertisement
>messages from VM via tap attached to host brighe, the src mac
>mighe be changed through balance-alb mode, but it is not synced
>with Link-layer address in the option message.
>
>The patch implements bond6's tx handle for ipv6 neighbor
>solicitation and advertisement messages.

	As previously discussed, this looks reasonable to me to resolve
the described MAC discrepancy.  One minor nit is a couple of misspelled
words in the description above, "brighe" and "mighe."

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

	-J

>Suggested-by: Hu Yadi <huyd12@chinatelecom.cn>
>Reported-by: kernel test robot <lkp@intel.com>
>Signed-off-by: Sun Shouxin <sunshouxin@chinatelecom.cn>
>---
> drivers/net/bonding/bond_alb.c | 36 ++++++++++++++++++++++++++++++++++
> 1 file changed, 36 insertions(+)
>
>diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_al=
b.c
>index 533e476988f2..82b7071840b1 100644
>--- a/drivers/net/bonding/bond_alb.c
>+++ b/drivers/net/bonding/bond_alb.c
>@@ -1269,6 +1269,34 @@ static int alb_set_mac_address(struct bonding *bon=
d, void *addr)
> 	return res;
> }
> =

>+/*determine if the packet is NA or NS*/
>+static bool __alb_determine_nd(struct icmp6hdr *hdr)
>+{
>+	if (hdr->icmp6_type =3D=3D NDISC_NEIGHBOUR_ADVERTISEMENT ||
>+	    hdr->icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION) {
>+		return true;
>+	}
>+
>+	return false;
>+}
>+
>+static bool alb_determine_nd(struct sk_buff *skb, struct bonding *bond)
>+{
>+	struct ipv6hdr *ip6hdr;
>+	struct icmp6hdr *hdr;
>+
>+	if (skb->protocol =3D=3D htons(ETH_P_IPV6)) {
>+		ip6hdr =3D ipv6_hdr(skb);
>+		if (ip6hdr->nexthdr =3D=3D IPPROTO_ICMPV6) {
>+			hdr =3D icmp6_hdr(skb);
>+			if (__alb_determine_nd(hdr))
>+				return true;
>+		}
>+	}
>+
>+	return false;
>+}
>+
> /************************ exported alb functions ***********************=
*/
> =

> int bond_alb_initialize(struct bonding *bond, int rlb_enabled)
>@@ -1350,6 +1378,9 @@ struct slave *bond_xmit_tlb_slave_get(struct bondin=
g *bond,
> 		switch (skb->protocol) {
> 		case htons(ETH_P_IP):
> 		case htons(ETH_P_IPV6):
>+			if (alb_determine_nd(skb, bond))
>+				break;
>+
> 			hash_index =3D bond_xmit_hash(bond, skb);
> 			if (bond->params.tlb_dynamic_lb) {
> 				tx_slave =3D tlb_choose_channel(bond,
>@@ -1446,6 +1477,11 @@ struct slave *bond_xmit_alb_slave_get(struct bondi=
ng *bond,
> 			break;
> 		}
> =

>+		if (alb_determine_nd(skb, bond)) {
>+			do_tx_balance =3D false;
>+			break;
>+		}
>+
> 		hash_start =3D (char *)&ip6hdr->daddr;
> 		hash_size =3D sizeof(ip6hdr->daddr);
> 		break;
>
>base-commit: 79e06c4c4950be2abd8ca5d2428a8c915aa62c24
>-- =

>2.27.0
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
