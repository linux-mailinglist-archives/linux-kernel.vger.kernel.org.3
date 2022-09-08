Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFDF5B16D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiIHIXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiIHIX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:23:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8DAB4416;
        Thu,  8 Sep 2022 01:23:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t7so19703443wrm.10;
        Thu, 08 Sep 2022 01:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=xc4RgE3PUhocOgenP0ywVlkdXr/eaf54hZdXFi8BVb0=;
        b=mbCVQGm4IfnN3MFd0T/X57SrahPJpL7q3pQfgaTPUsZKr6hdByFKzIKN72QMTn6GU5
         QvPK1lp9EPiVgekD8z6yWf/vU7yi9jqxeYiE9q+y0RGcKgtPiv9DKzd3PblYPxEhgayl
         cMvwNx8vSqIUamnYEL8HZSl6hQSCmhcI2tew0TmLPrJM1OCHC5nXL/aguYXPxg5WOL6N
         Ml68kGSi/Z5tl9bcTvhdFFuZ3q7MpIGdZE1UKsDqLZDF9o5WYTruHhYAxPyN29h+a8KY
         8tDq+In0jE0gD7tw6X3yQMcAn5rhVrk/bi55XpV3omWwzkE16j/m5nV9NfgKSh1qZlQK
         qPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=xc4RgE3PUhocOgenP0ywVlkdXr/eaf54hZdXFi8BVb0=;
        b=Vs1S39nnIWzp5QwHNkGHbVA6TvwNa6Ke8qezMWXwsQNnTKZh3eDgmHT5M2Awh6RACA
         DdFA3NAi8TGAjtlGCH8nAoAgU0tVIiXISYEsXyDigbisVKgKLiNbFGIChH8IUhpWIuAH
         6E/K8sKzP/nWj+OmewEGWQFZytdMoh3LGqo20c/ObJD1kV2rjzcqTrTXMeMme2fc0U4N
         KKWZCxjfb48YGGph82YW8heJwi4veWCIR3Ysqg1UV1j0SOnBx4s6OGn31JE0V3S/bv+J
         nNU9YJuCUS4i95f4LsbW27M0pcftev69V3bvXkv7UIjIQV2sGbcZd3XOKD0Khphhtxtk
         lS5A==
X-Gm-Message-State: ACgBeo0D3aWPVa+OeTmu9WMw8tOC0trfNsNYTsz508HYaybw+vdPfhxF
        uBDUSF4hyLDKLopPSuZvnqQ=
X-Google-Smtp-Source: AA6agR5By09qzajZi0KlG/79DDr8MNO8fRvENdlAnUfP9IUmP6OWcxnCFC3YaXbX7SRznWxHMdE/Zg==
X-Received: by 2002:a5d:5273:0:b0:228:b382:8ea0 with SMTP id l19-20020a5d5273000000b00228b3828ea0mr4192991wrc.347.1662625402705;
        Thu, 08 Sep 2022 01:23:22 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id p21-20020a1c7415000000b003b2878b9e0dsm1830540wmc.20.2022.09.08.01.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:23:22 -0700 (PDT)
Message-ID: <6b56ad5fd5b5ab128afd399adb54a7566c4a144f.camel@gmail.com>
Subject: Re: [RFC PATCH v3 1/4] ufs: core: prepare ufs for multi circular
 queue support
From:   Bean Huo <huobean@gmail.com>
To:     "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        bvanassche@acm.org, avri.altman@wdc.com, mani@kernel.org,
        quic_cang@quicinc.com, beanhuo@micron.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 08 Sep 2022 10:23:20 +0200
In-Reply-To: <df32bbd5-4109-903b-c7ba-7777a298f5aa@quicinc.com>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
         <757bbfe36629b7c31ef2630971f8678a7801223f.1662157846.git.quic_asutoshd@quicinc.com>
         <6e594dc2ce6103884b7768c2fed55eabec0d5ed8.camel@gmail.com>
         <df32bbd5-4109-903b-c7ba-7777a298f5aa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA5LTA3IGF0IDIwOjAwIC0wNzAwLCBBc3V0b3NoIERhcyAoYXNkKSB3cm90
ZToKPiA+ID4gdWZzaGNkX2xyYiAqbHJicCwgdTggdXBpdV9mbGFncykKPiA+ID4gwqAgwqDCoMKg
wqDCoMKgwqDCoC8qIGNvbW1hbmQgZGVzY3JpcHRvciBmaWVsZHMgKi8KPiA+ID4gwqAgwqDCoMKg
wqDCoMKgwqDCoHVjZF9yZXFfcHRyLT5oZWFkZXIuZHdvcmRfMCA9IFVQSVVfSEVBREVSX0RXT1JE
KAo+ID4gPiDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgVVBJVV9UUkFOU0FDVElPTl9DT01NQU5ELAo+ID4gPiB1cGl1X2Zs
YWdzLAo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBscmJwLT5sdW4sIGxyYnAtPnRhc2tfdGFnKTsKPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
bHJicC0+bHVuLCBscmJwLT50YXNrX3RhZyAmCj4gPiA+IDB4ZmYpOwo+ID4gPiDCoCDCoMKgwqDC
oMKgwqDCoMKgdWNkX3JlcV9wdHItPmhlYWRlci5kd29yZF8xID0gVVBJVV9IRUFERVJfRFdPUkQo
Cj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoFVQSVVfQ09NTUFORF9TRVRfVFlQRV9TQ1NJLCAwLCAwLAo+ID4gPiAwKTsK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgVVBJVV9DT01NQU5EX1NFVF9UWVBFX1NDU0ksIDAsIDAsCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oChscmJwLT50YXNrX3RhZyAmIDB4ZjAwKSA8PCA0KTsKPiA+ID4gwqDCoCAKPiA+IAo+ID4gQXJl
IHlvdSBzdXJlIGhlcmUgIihscmJwLT50YXNrX3RhZyAmIDB4ZjAwKSA8PCA0IiBpcyBjb3JyZWN0
Pwo+ID4gCj4gRVhUX0lJRCBpcyB0aGUgaGlnaGVyIG5pYmJsZSBpbiBEV09SRDEuIFNvIHRoaXMg
bG9va3MgY29ycmVjdCB0byBtZS4KPiAKPiBDT01NQU5EIFVQSVUKPiAwwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMcKgwqDCoMKgIDLCoMKgwqDCoMKgMwo+IHh4MDAwMDAxYiBGbGFncyBMVU4gVGFzayBU
YWcKPiA0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDXCoMKg
wqDCoMKgwqDCoDbCoMKgwqDCoMKgwqDCoDcKPiBJSUQgQ29tbWFuZCBTZXQgVHlwZSBSZXNlcnZl
ZCBSZXNlcnZlZCBFWFRfSUlEIHwgUmVzZXJ2ZWQKCkhpIEFzdXRvc2gsCgp5ZXMsIFs3OjRdIG9m
IGJ5dGUgNyBpbiBVUElVIGhlYWRlciBmb3IgaG9zdCB0byBkZXZpY2UgVVBJVXMgRVhUX0lJRCwK
dGhpcyBpcyBjb3JyZWN0LgoKYnV0IEkgdGhpbmsgYnl0ZTcgc2hvdWxkIGJlICAobHJicC0+dGFz
a190YWcgJiAweGYwMCkgPj4gNCk7IHJhdGhlcgp0aGFuICI8PCA0IgoKb3Igd2hhdCBJIG1pc3N1
bmRlcnNvb2QuCgoKS2luZCByZWdhcmRzLApCZWFuCgoK

